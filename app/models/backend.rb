class Service 
  include ActiveModel::Model
  attr_accessor :identifier, :name, :provider
  attr_accessor :protocol, :format

  def self.all
    @cache ||= Registry.backends
  end

  def self.find_by_id(service_id)
    all.find {|s| s.id==service_id}
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
