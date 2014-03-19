class EmailThread
  attr_accessor :message_ids, :mailing_list_name, :id, :date, :subject

  def self.recent(number)
    client.search("~inbox", number).collect do |thread|
      find(thread['thread_id'])
    end.reject { |thread| thread.mailing_list.nil? || thread.mailing_list.name.nil? }
  end

  def self.find_by_mailing_list(mailing_list)
    mailing_list = mailing_list.try(:name) if mailing_list.class == MailingList
    if result = client.search(mailing_list).first
      find(result['thread_id'])
    else
      nil
    end
  end

  def self.where(mailing_list: nil, mailing_lists: nil)
    if mailing_lists.present?
      mailing_lists.collect { |mailing_list| self.where(mailing_list: mailing_list) }.flatten.sort_by(&:date).reverse
    else
      client.search(mailing_list).collect { |thread| find(thread['thread_id']) }.uniq.compact.sort_by(&:date).reverse
    end
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
    self.subject           = sample_message.subject.gsub(/(re:)/i, "").strip.capitalize
  end

  def messages
    @messages ||= self.message_ids.collect { |id| Email.find(id) }
  end

  def date
    self.messages.first.date
  end

  def mailing_list
    @mailing_list ||= MailingList.where(name: self.mailing_list_name).first
  end

  def author
    @author ||= self.messages.first.user
  end

  private

    def self.client
      @client ||= HeliotropeClient.new(ENV['HELIOTROPE_ADDRESS'])
    end
end