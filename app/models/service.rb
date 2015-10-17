class Service 
  include ActiveModel::Model
  attr_accessor :id, :name, :group

  def self.all
    @cache ||= Backend.services
  end

  def self.find_by_id(service_id)
    all.find {|s| s.id==service_id}
  end

  def subscriptions
   Subscription.find_all_by_service_id(self.id) 
  end

  def to_s
    name
  end

  def persisted?
    true
  end
end
