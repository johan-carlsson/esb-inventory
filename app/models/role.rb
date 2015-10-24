class Role
  include ActiveModel::Model
  attr_accessor :name,:contact

  def initialize(contact,on_type,on_id,name)
    self.name=name
    self.contact=contact
    @on_type=on_type
    @on_id=on_id
  end

  def self.find_by_id(id)
    all.find {|s| s.id==id}
  end

  def self.all
    Contact.all.map do |contact|
      contact.roles
    end.flatten
  end

  def self.find_all_by_service_id(service_id)
    s=Service.find_by_id(service_id)
    all.find_all { |role | role.on==s }
  end

  def self.find_all_by_system_id(system_id)
    s=System.find_by_id(system_id)
    all.find_all { |role | role.on==s }
  end

  def self.find_all_by_client_id(client_id)
    s=Client.find_by_id(client_id)
    all.find_all { |role | role.on==s }
  end

  def self.find_all_by_backend_id(backend_id)
    s=Backend.find_by_id(backend_id)
    all.find_all { |role | role.on==s }
  end

  def on
    klass=Object.const_get(@on_type.classify)
    klass.find_by_id(@on_id)
  end

  def on_name
    "#{on.class} #{on.to_s}"
  end

  def id
    self.name.gsub(/[^\w]/,"_") 
  end

  def persisted?
    true
  end

end
