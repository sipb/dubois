class EmailThread
  attr_accessor :message_ids, :mailing_list_name, :id, :date

  def self.find_by_mailing_list(mailing_list)
    mailing_list = mailing_list.try(:name) if mailing_list.class == MailingList
    if result = client.search(mailing_list).first
      find(result['thread_id'])
    else
      nil
    end
  end

  def self.where(mailing_list: nil)
    client.search(mailing_list).collect { |thread| find(thread['thread_id']) }.uniq.compact
  end

  def self.find(id)
    if result = client.thread(id)
      EmailThread.new(result)
    end
  end

  def initialize(thread)
    self.message_ids = thread.collect { |message| message.first['message_id'] }
  end

  def message_ids=(val)
    @message_ids = val

    sample_message         = self.messages.sample
    self.id                = sample_message.thread_id
    self.mailing_list_name = sample_message.mailing_list_name 
  end

  def messages
    @messages ||= self.message_ids.collect { |id| Email.find(id) }
  end

  def date
    self.messages.first.date
  end

  def mailing_list
    @mailing_list ||= MailingList.where(name: self.mailing_list_name)
  end

  private

    def self.client
      @client ||= HeliotropeClient.new(ENV['HELIOTROPE_ADDRESS'])
    end
end