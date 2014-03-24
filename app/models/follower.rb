class Follower < ActiveRecord::Base
  belongs_to :user
  belongs_to :mailing_list

  validates_uniqueness_of :user_id, :scope => [ :mailing_list_id ]
end
