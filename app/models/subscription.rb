class Subscription 
  include ActiveModel::Model
  attr_accessor  :service_id,:client_id,:starts_at, :ends_at

  def self.all
    Registry.subscriptions
  end

  def self.find_all_by_client_id(id)
    all.find_all {|s| s.client_id == id}
  end

  def self.find_all_by_service_id(id)
    all.find_all {|s| s.service_id == id}
  end

  def client
    Client.find_by_id(self.client_id)    
  end

  def service
    Service.find_by_id(self.service_id)    
  end

  def persisted?
    true
  end

end
