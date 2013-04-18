class Consumer < ActiveRecord::Base
  stampable
  acts_as_ordered_taggable
  attr_accessible :name,:identifier,:tag_list

  default_scope where(:deleted_at => nil)

  has_many :subscriptions, :dependent => :destroy
  has_many :consumer_contacts, :dependent => :destroy
  has_many :contacts, :through => :consumer_contacts
  belongs_to :readme

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_s
    name
  end
end
