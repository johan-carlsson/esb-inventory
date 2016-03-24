class Subscription 
  include ActiveModel::Model
  attr_accessor  :integration_id,:client_id,:debit_system_id,:starts_at, :ends_at

  def self.all
    Registry.subscriptions
  end

  def self.find_all_by_client_id(id)
    all.find_all {|s| s.client_id == id}
  end

  def self.find_all_by_integration_id(id)
    all.find_all {|s| s.integration_id == id}
  end

  def client
    Client.find_by_id(self.client_id)    
  end

  def debit_system
    System.find_by_id(self.debit_system_id)
  end

  # Who should pay for this subscription
  def subscriber
    debit_system || client
  end

  def subscriber_id
    subscriber.id
  end


  def integration
    Integration.find_by_id(self.integration_id)    
  end

  def ended?
    self.ends_at && self.ends_at <= Date.today
  end

  def started?
    self.starts_at && self.starts_at <= Date.today
  end

  def persisted?
    true
  end

end
