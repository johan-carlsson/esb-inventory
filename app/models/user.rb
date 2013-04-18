class User < ActiveRecord::Base
  has_secure_password
  model_stamper
  stampable
  acts_as_ordered_taggable
  attr_accessible :name, :password, :password_confirmation,:tag_list

  default_scope where(:deleted_at => nil)

  validates_presence_of :name
  validates_uniqueness_of :name
  def to_s
    name
  end
end
