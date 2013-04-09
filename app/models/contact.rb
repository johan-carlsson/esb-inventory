class Contact < ActiveRecord::Base
  stampable
  attr_accessible :email, :name

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_s
    name
  end

end
