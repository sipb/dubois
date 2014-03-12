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
    self.date               = Time.at(messageinfo[:date]).to_datetime
    self.from               = messageinfo[:from].first
    self.to                 = messageinfo[:to].first
    self.thread_id          = messageinfo[:thread_id]
    self.snippet            = messageinfo[:snippet]
    self.cc                 = messageinfo[:cc]
    self.body               = messageinfo[:parts].first['content']

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

  def cc=(val)
    # Pull the email from the list of CC's. Look for one that we have a matching mailing list for. Return that one's name.
    self.mailing_list_name = val.select { |cc| MailingList.where(name: cc.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i).first).first.try(:name) }.first

    @cc = val
  end

  private

    def self.client
      @client ||= HeliotropeClient.new(ENV['HELIOTROPE_ADDRESS'])
    end
end