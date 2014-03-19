class Email
  attr_accessor :Id, :subject, :from, :to, :thread_id, :id, :snippet, :body, :cc, :date, :mailing_list_name, :body
  EMAIL_REGEX = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i.freeze unless defined?(EMAIL_REGEX)

  def self.find(id)
    id = id.id if id.class == Email
    Email.new(client.message(id))
  end

  def initialize(messageinfo)
    messageinfo = messageinfo.with_indifferent_access

    self.id                 = messageinfo[:message_id]
    self.subject            = messageinfo[:subject]
    self.date               = Time.at(messageinfo[:date]).to_datetime
    self.from               = messageinfo[:from].first
    self.to                 = messageinfo[:to]
    self.thread_id          = messageinfo[:thread_id]
    self.snippet            = messageinfo[:snippet]
    self.cc                 = messageinfo[:cc]
    self.body               = messageinfo[:parts].first['content']

    deduce_mailing_list!

    self
  end

  def user
    
    @user ||= User.where(email: self.from).first_or_create!
  end

  def subscriber
    @subscriber ||= self.mailing_list.subscibers.where(:user_id => self.user.id)
  end

  def mailing_list
    @mailing_list ||= MailingList.where(name: self.mailing_list_name).first
  end

  def thread
    @thread ||= EmailThread.find(self.thread_id)
  end

  private

    def deduce_mailing_list!
      possible_names = self.cc.collect  { |cc| cc.scan(EMAIL_REGEX).first }
      possible_names << self.to.collect { |to| to.scan(EMAIL_REGEX).first }
      self.mailing_list_name = MailingList.where(:name => possible_names).first.try(:name)
    end

    def self.client
      @client ||= HeliotropeClient.new(ENV['HELIOTROPE_ADDRESS'])
    end
end