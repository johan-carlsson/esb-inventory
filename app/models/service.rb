class Service < ActiveRecord::Base
  attr_accessible :name,:category

  has_many :subscriptions

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:category]

  def to_s
    name
  end
end
