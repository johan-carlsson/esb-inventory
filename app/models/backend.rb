class Backend 
  include ActiveModel::Model
  attr_accessor :identifier, :name, :system,:system_id
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

  def services
   ServiceBackend.find_all_by_backend_id(self.id).map{|s| s.service}
  end

  def service_count
    services.count
  end

  def system
    System.find_by_id(system_id)
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
