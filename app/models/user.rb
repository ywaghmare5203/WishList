class User < ActiveRecord::Base
  attr_accessible  :address, :terms,:bio, :birthday, :city,:name,:last_login_time, :country, :email, :facebook_id, :fb_token, :first_name, :gender, :is_active, :last_name, :lat, :longitude, :password_hash, :password_salt, :phone, :privacy, :provider, :registration_id, :screen_name, :twitter_id, :website, :password, :password_confirmation, :profile_picture, :cover_photo, :nationality
  attr_accessor :password
  before_save :encrypt_password
  validates_confirmation_of :password
  validates_uniqueness_of :email
  

  has_many :products ,:dependent => :destroy
has_attached_file :profile_picture,
      :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
      :url => "/system/:attachment/:id/:style/:filename"


def encrypt_password
  if password.present?
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
  end
end


def self.authenticate(email, password)
  user = find_by_email(email)
  if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
     user
  else
     nil
  end
end

   def self.authenticate_password(email, password)
    user = User.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
   end
end
