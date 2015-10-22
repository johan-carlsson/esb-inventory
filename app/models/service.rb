class Service 
  include ActiveModel::Model
  attr_accessor :identifier, :name, :group, :provider
  attr_accessor :protocol, :format
  attr_accessor :properties

  def self.all
    Registry.services
  end

  def self.find_by_id(service_id)
    all.find {|s| s.id==service_id}
  end

  def initialize
    @properties=[]
  end

  def subscriptions
   Subscription.find_all_by_service_id(self.id) 
  end

  def relations
   ServiceRelation.find_all_by_service_id(self.id) 
  end

  def to_s
    name
  end

  def id
    self.identifier.gsub(/[^\w]/,"_") 
  end

  def persisted?
    true
  end
end
