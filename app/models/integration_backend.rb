class IntegrationBackend
  include ActiveModel::Model
  attr_accessor :integration_id, :backend_id

  def self.all
    Registry.integration_backends
  end

  def self.find_all_by_backend_id(id)
   all.find_all {|s| s.backend_id == id}
  end

  def self.find_all_by_integration_id(id)
   all.find_all {|s| s.integration_id == id}
  end

  def initialize(integration_id,backend_id)
    self.integration_id=integration_id
    self.backend_id=backend_id
  end

  def integration
    Integration.find_by_id(self.integration_id)    
  end

  def backend
    Backend.find_by_id(self.backend_id)    
  end

  def persisted?
    true
  end
end
