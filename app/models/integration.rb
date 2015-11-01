class Integration 
  include ActiveModel::Model
  attr_accessor :identifier, :name, :group, :system_id,:type
  attr_accessor :protocol, :format
  attr_accessor :properties
  attr_accessor :description,:tags

  def self.all
    Registry.integrations
  end

  def self.find_by_id(id)
    all.find {|s| s.id==id}
  end

  def self.find_all_by_system_id(system_id)
    all.find_all {|s| s.system_id==system_id}
  end

  def initialize(identifier)
    self.identifier=identifier
    @properties=[]
  end

  def subscriptions
   Subscription.find_all_by_integration_id(self.id) 
  end

  def client_count
   subscriptions.count
  end

  def relations
   IntegrationRelation.find_all_by_integration_id(self.id) 
  end

  def backends
   IntegrationBackend.find_all_by_integration_id(self.id).map {|s| s.backend}
  end

  def contact_roles
    Role.find_all_by_integration_id(self.id)
  end

  def system
    System.find_by_id(system_id)
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
