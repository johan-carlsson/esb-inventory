class Contact
  include ActiveModel::Model
  attr_accessor :name,:email,:phone,:identifier
  attr_accessor :properties
  attr_accessor :description,:tags
  attr_accessor :roles

  def self.all
    Registry.contacts
  end


  def initialize(name)
    self.name=name
    self.properties=[]
    self.roles=[]
  end

  def self.find_by_id(id)
    all.find {|s| s.id==id}
  end


  def id
    (identifier || email || phone || name).gsub(/[^\w]/,"_") 
  end

  def to_s
   name 
  end

  def persisted?
    true
  end

end
