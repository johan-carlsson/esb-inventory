class Consumer < ActiveRecord::Base
  stampable
  attr_accessible :name,:identifier

  default_scope where(:deleted_at => nil)

  has_many :subscriptions

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_s
    name
  end
end
