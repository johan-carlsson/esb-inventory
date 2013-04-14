class Contact < ActiveRecord::Base
  stampable
  attr_accessible :email, :name,:phone,:mobile

  default_scope where(:deleted_at => nil)

  has_many :consumer_contacts, :dependent => :destroy
  has_many :consumers, :through => :consumer_contacts
  has_many :provider_contacts, :dependent => :destroy
  has_many :providers, :through => :provider_contacts

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_s
    name
  end

end
