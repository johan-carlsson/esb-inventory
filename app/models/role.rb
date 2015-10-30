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

  def self.find_all_by_system_id(system_id)
    s=System.find_by_id(system_id)
    all.find_all { |role | role.on==s }
  end

  def self.find_all_by_service_id(service_id)
    s=Service.find_by_id(service_id)
    roles=all.find_all { |role | role.on==s }
    if s.system
      inherited_roles=self.find_all_by_system_id(s.system.id).map{|r| r.inherited=true;r}
      uniq=inherited_roles.inject(roles) do |agg_roles,r|
        if agg_roles.find{|a| a.contact.id==r.contact.id}
          agg_roles
        else
          # agg_roles
          agg_roles << r
        end
      end
    end
    uniq || [] 
  end


  def self.find_all_by_client_id(client_id)
    s=Client.find_by_id(client_id)
    roles=all.find_all { |role | role.on==s }
    if s.system
      inherited_roles=self.find_all_by_system_id(s.system.id).map{|r| r.inherited=true;r}
      uniq=inherited_roles.inject(roles) do |agg_roles,r|
        if agg_roles.find{|a| a.contact.id==r.contact.id}
          agg_roles
        else
          # agg_roles
          agg_roles << r
        end
      end
    end
    uniq || [] 
  end

  def self.find_all_by_backend_id(backend_id)
    s=Backend.find_by_id(backend_id)
    roles=all.find_all { |role | role.on==s }
    if s.system
      inherited_roles=self.find_all_by_system_id(s.system.id).map{|r| r.inherited=true;r}
      uniq=inherited_roles.inject(roles) do |agg_roles,r|
        if agg_roles.find{|a| a.contact.id==r.contact.id}
          agg_roles
        else
          # agg_roles
          agg_roles << r
        end
      end
    end
    uniq || [] 
  end

  def on
    klass=Object.const_get(@on_type.classify)
    klass.find_by_id(@on_id)
  end

  def on_name
    "#{on.class} #{on.to_s}"
  end

  def email
    contact.email
  end

  def inherited?
    @inherited
  end

  def inherited=(bool)
    @inherited=bool
  end

  def id
    self.name.gsub(/[^\w]/,"_") 
  end

  def persisted?
    true
  end

end
