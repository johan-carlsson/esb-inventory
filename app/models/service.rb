class Service < ActiveRecord::Base
  stampable
  acts_as_ordered_taggable
  attr_accessible :name,:category,:provider_name,:tag_list

  default_scope where(:deleted_at => nil)

  has_many :subscriptions, :dependent => :destroy
  belongs_to :provider
  belongs_to :readme

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
