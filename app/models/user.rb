class User < ActiveRecord::Base
  has_many :subscribers

  def name
    "dove"
  end
end
