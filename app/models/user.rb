class User < ActiveRecord::Base
  attr_accessible :email, :id, :password, :username
  has_many :photos
  
  def self.authenticate(username, password)
  	user = find_by_username(username)
  	if user.password == password
  		user
  	else
  		nil
  	end
  end
  
end
