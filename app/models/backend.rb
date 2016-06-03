class Backend 
  include ActiveModel::Model
  attr_accessor :identifier, :name, :group, :system,:system_id
  attr_accessor :properties
  attr_accessor :description,:tags

  def self.all
    Registry.backends
  end

  def self.find_by_id(id)
    all.find {|s| s.id==id}
  end

  def self.find_all_by_system_id(system_id)
    all.find_all {|s| s.system_id==system_id}
  end

  def initialize(identifier)
    @properties=[]
    self.identifier=identifier
  end

  def integrations
   IntegrationBackend.find_all_by_backend_id(self.id).map{|s| s.integration}
  end

  def integration_count
    integrations.count
  end

  def system
    System.find_by_id(system_id)
  end

  def group
    @group || (system && system.group)
  end

  def contact_roles
    Role.find_all_by_backend_id(self.id)
  end

  def to_s
    name
  end

  def name
    @name || (system && system.name) || identifier
  end

  def id
    self.identifier.gsub(/[^\w]/,"_") 
  end

  def persisted?
    true
  end
end
