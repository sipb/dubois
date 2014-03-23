class EmailThread
  attr_accessor :message_ids, :mailing_list_name, :id, :date, :subject

  def self.recent(number)
    query("~inbox", count: number)
  end

  def self.find_by_mailing_list(mailing_list)
    mailing_list = mailing_list.try(:name) if mailing_list.class == MailingList
    query(mailing_list_query(mailing_list)).first
  end

  def self.search(name, count: 20, page: 1)
    query(name, count: count, page: page)
  end

  def self.where(mailing_list: nil, mailing_lists: nil, count: 20, page: 1)
    if mailing_lists.present?
      mailing_lists.collect { |mailing_list| self.where(mailing_list: mailing_list) }.flatten.sort_by(&:date).reverse
    else
      query(mailing_list_query(mailing_list.try(:name) || mailing_list), count: count, page: page)
    end
  end

  def self.for_mailing_list(mailing_list: nil, name: nil, page: 1, count: 20)
    q = mailing_list_query(mailing_list)
    q << "AND (body:#{name})" if name.present?
    query(q, page: page, count: count)
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

    def self.query(name, page: 1, count: 20)
      offset = count * (page - 1)
      client.search(name, count, offset).collect do |thread| 
        find(thread['thread_id'])
      end.reject do |thread|
        thread.mailing_list_name.blank?
      end.uniq.compact.sort_by(&:date).reverse
    end

    def self.mailing_list_query(name)
      "(from: \"#{name}\" OR cc: \"#{name}\")"
    end
end