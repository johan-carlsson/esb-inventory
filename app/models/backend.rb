class Backend 
  include ActiveModel::Model
  attr_accessor :identifier, :name, :provider,:system_id
  attr_accessor :properties

  def self.all
    Registry.backends
  end

  def self.find_by_id(id)
    all.find {|s| s.id==id}
  end

  def initialize
    @properties=[]
  end

  def services
   ServiceBackend.find_all_by_backend_id(self.id).map{|s| s.service}
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
