class ConsumerContact < ActiveRecord::Base
  ROLES=%w( Administrator Arcitect Developer Maintainer Manager Support Owner )
  attr_accessible :role,:contact_name 

  default_scope where(:deleted_at => nil)

  belongs_to :consumer
  belongs_to :contact

  validates_uniqueness_of :contact_id, :scope => [:consumer_id,:role], :message => "already has a contact with this role"

  def contact_name
    self.contact.try(:name)
  end

  def contact_name=(name)
   self.contact=Contact.find_or_create_by_name(name) 
  end
end
