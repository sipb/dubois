class User < ActiveRecord::Base
  has_many :subscribers
end
