class Consumer
  include ActiveModel::Model
  attr_accessor  :identifier,:name

  def self.all
    @cache ||= Registry.consumers
  end

  def self.find_by_id(id)
    all.find {|s| s.id==id}
  end

  def subscriptions
   Subscription.find_all_by_consumer_id(self.id) 
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
