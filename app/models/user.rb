class User < ActiveRecord::Base
  has_secure_password

 attr_accessible :name, :password, :password_confirmation

  validates_presence_of :name
  validates_uniqueness_of :name
end
