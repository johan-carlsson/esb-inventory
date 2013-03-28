class Consumer < ActiveRecord::Base
  attr_accessible :name
  has_many :subscriptions
  def to_s
    name
  end
end
