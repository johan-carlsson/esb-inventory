class Subscription 
  include ActiveModel::Model
  attr_accessor  :service_id,:consumer_id,:starts_at, :ends_at

  def self.all
    Backend.subscriptions
  end

  def self.find_all_by_consumer_id(id)
    all.find_all {|s| s.consumer_id == id}
  end

  def self.find_all_by_service_id(id)
    all.find_all {|s| s.service_id == id}
  end

  def consumer
    Consumer.find_by_id(self.consumer_id)    
  end

  def service
    Service.find_by_id(self.service_id)    
  end

  def persisted?
    true
  end

end
