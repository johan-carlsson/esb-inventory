class Provider < ActiveRecord::Base
  stampable
  attr_accessible :name,:identifier
  
  has_many :services 
  has_many :subscriptions, :through => :services  
  has_many :consumers, :through => :subscriptions, :uniq => true 

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_s
    name
  end

end
