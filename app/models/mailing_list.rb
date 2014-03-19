class MailingList < ActiveRecord::Base
  has_many :subscribers

  def threads
    EmailThread.where(mailing_list: self.name)
  end
  
end
