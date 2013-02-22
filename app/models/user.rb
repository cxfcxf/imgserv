class User < ActiveRecord::Base
  attr_accessible :email, :id, :password, :username
  has_many :photos
end
