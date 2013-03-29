class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable, 
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :photos, :dependent => :destroy
  
  def valid_password?(password)
  	return false if encrypted_password.blank?
    if encrypted_password.length > 32
      bcrypt   = ::BCrypt::Password.new(encrypted_password)
      password = ::BCrypt::Engine.hash_secret("#{password}#{self.class.pepper}", bcrypt.salt)
      Devise.secure_compare(password, encrypted_password)
    else
      Devise.secure_compare(Digest::MD5.hexdigest(password), self.encrypted_password)
    end
  end
  
end
