class ServiceBackend
  include ActiveModel::Model
  attr_accessor :service_id, :backend_id

  def self.all
    Registry.service_backends
  end

  def self.find_all_by_backend_id(id)
   all.find_all {|s| s.backend_id == id}
  end

  def self.find_all_by_service_id(id)
   all.find_all {|s| s.service_id == id}
  end

  def initialize(service_id,backend_id)
    self.service_id=service_id
    self.backend_id=backend_id
  end

  def service
    Service.find_by_id(self.service_id)    
  end

  def backend
    Backend.find_by_id(self.backend_id)    
  end

  def persisted?
    true
  end
end
