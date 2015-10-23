class Provider 
  include ActiveModel::Model
  attr_accessor :identifier, :name
  attr_accessor :properties

  def self.all
    Registry.providers
  end

  def self.find_by_id(id)
    all.find {|s| s.id==id}
  end

  def initialize(id)
    self.identifier=id
    @properties=[]
  end

  def services
   Service.find_all_by_provider_id(self.id)
  end

  def backends
   Backend.find_all_by_provider_id(self.id)
  end

  def consumers
   Consumer.find_all_by_provider_id(self.id)
  end

  def provides
   services + backends + consumers
  end

  def provide_count
   provides.length
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
