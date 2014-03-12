class Email
  attr_accessor :Id, :subject, :from, :to, :thread_id, :id, :snippet, :body, :cc, :date, :mailing_list_name, :body

  def self.find(id)
    id = id.id if id.class == Email
    Email.new(client.message(id))
  end

  def initialize(messageinfo)
    messageinfo = messageinfo.with_indifferent_access

    self.id                 = messageinfo[:message_id]
    self.subject            = messageinfo[:subject]
    self.from               = messageinfo[:from].first
    self.to                 = messageinfo[:to].first
    self.thread_id          = messageinfo[:thread_id]
    self.snippet            = messageinfo[:snippet]
    self.cc                 = messageinfo[:cc]
    self.mailing_list_name  = messageinfo[:recipient_email].split("@").first if messageinfo[:recipient_email].present?
    self.body               = messageinfo[:parts].first['content']

    self
  end

  def user
    @user ||= User.where(email: self.from).first
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

    def self.client
      @client ||= HeliotropeClient.new(ENV['HELIOTROPE_ADDRESS'])
    end
end