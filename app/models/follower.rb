class Follower < ActiveRecord::Base
  belongs_to :user
  belongs_to :mailing_list

  validates :mailing_list, :presence => true
  validates :user,         :presence => true, :uniqueness => { :scope => [:mailing_list_id] }
end
