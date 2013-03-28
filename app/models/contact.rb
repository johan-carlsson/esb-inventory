class Contact < ActiveRecord::Base
  attr_accessible :email, :name
  def to_s
    name
  end

end
