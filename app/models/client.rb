class Client
  include ActiveModel::Model
  attr_accessor  :identifier,:name, :system_id
  attr_accessor :properties

  def self.all
    Registry.clients
  end

  def self.find_by_id(id)
    all.find {|s| s.id==id}
  end

  def self.find_all_by_system_id(system_id)
    all.find_all {|s| s.id==system_id}
  end

  def initialize
    @properties=[]
  end

  def system
    System.find_by_id(system_id)
  end

  def subscriptions
   Subscription.find_all_by_client_id(self.id) 
  end

  def service_count
    subscriptions.count
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
