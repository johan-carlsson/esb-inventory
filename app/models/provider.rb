class Provider < ActiveRecord::Base
  stampable
  attr_accessible :name,:identifier
  
  default_scope where(:deleted_at => nil)

  has_many :services 
  has_many :subscriptions, :through => :services  
  has_many :consumers, :through => :subscriptions, :uniq => true 
  has_many :provider_contacts, :dependent => :destroy
  has_many :contacts, :through => :provider_contacts
  belongs_to :readme

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_s
    name
  end

end
