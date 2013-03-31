class Service < ActiveRecord::Base
  attr_accessible :name,:category,:provider_name

  has_many :subscriptions
  belongs_to :provider

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:category]

  def to_s
    name
  end
  
  def provider_name
    self.provider.try(:name)
  end

  def provider_name=(name)
    self.provider=Provider.find_or_create_by_name(name) 
  end

end
