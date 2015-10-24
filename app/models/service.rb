class Service 
  include ActiveModel::Model
  attr_accessor :identifier, :name, :group, :provider_id
  attr_accessor :protocol, :format
  attr_accessor :properties

  def self.all
    Registry.services
  end

  def self.find_by_id(id)
    all.find {|s| s.id==id}
  end

  def self.find_all_by_provider_id(provider_id)
    all.find_all {|s| s.provider_id==provider_id}
  end

  def initialize
    @properties=[]
  end

  def subscriptions
   Subscription.find_all_by_service_id(self.id) 
  end

  def client_count
   subscriptions.count
  end

  def relations
   ServiceRelation.find_all_by_service_id(self.id) 
  end

  def backends
   ServiceBackend.find_all_by_service_id(self.id).map {|s| s.backend}
  end

  def provider
    Provider.find_by_id(provider_id)
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
