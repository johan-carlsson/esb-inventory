class Subscription < ActiveRecord::Base
  validates_uniqueness_of :service_id, :scope => :consumer_id
  validates_uniqueness_of :consumer_id, :scope => :service_id
  belongs_to :service
  belongs_to :consumer
  attr_accessible :service_id,:consumer_id
end
