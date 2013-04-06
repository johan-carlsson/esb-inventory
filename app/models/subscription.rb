class Subscription < ActiveRecord::Base
  belongs_to :service
  belongs_to :consumer

  validates_uniqueness_of :service_id, :scope => :consumer_id, :message => "already has a subscription for this consumer"
  validates_presence_of :consumer_id,:service_id

  attr_accessible :service_name,:consumer_name,:starts_at,:ends_at

  def consumer_name
    self.consumer.try(:name)
  end

  def consumer_name=(name)
   self.consumer=Consumer.find_or_create_by_name(name) 
  end

  def service_name
    self.service.try(:name)
  end

  def service_name=(name)
   self.service=Service.find_or_create_by_name(name) 
  end
end
