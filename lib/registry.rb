class Registry
  require 'nokogiri'

  CACHE_DURATION=1.minutes

  def self.integrations
    Rails.cache.fetch("integrations", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched integrations"
      integrations=[]
      doc = File.open("./lib/integrations.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//integration").each do |node| 
        s=Integration.new(node.xpath("integrationId").text)
        set_text_value("name",s,node)
        s.protocol=node.xpath("protocol").text
        if s.protocol == "http"
          s.format="soap/xml"
          s.properties << Property.new("Format","soap/xml")
          s.properties << Property.new("Protocol","http")
          s.type="service"
        end
        if s.protocol== "mq"
          s.properties << Property.new("Protocol","mq")
          s.properties << Property.new("Format","xml")
          s.type="pub/sub"
        end
        s.group=node.xpath("group").text
        s.system_id=System.new("I05").id

        #Properties
        s.properties << Property.new("Timeout",1000)
        integrations << s
      end
      integrations
    end
  end


  def self.integration_relations
    Rails.cache.fetch("integration_relations", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched integration relations"
      integration_relations=[]
      doc = File.open("./lib/integration_relations.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//relations").each do |node| 
        s=Integration.new(node.xpath("../id").text)

        node.xpath("use").each do |use_node|
          u=Integration.new(use_node.xpath("integrationId").text)
          sr=IntegrationRelation.new
          sr.relation_type="Use"
          sr.integration_id=s.id
          sr.related_integration_id=u.id
          integration_relations << sr
        end

        node.xpath("usedBy").each do |used_by_node|
          u=Integration.new(used_by_node.xpath("integrationId").text)
          sr=IntegrationRelation.new
          sr.relation_type="UsedBy"
          sr.integration_id=s.id
          sr.related_integration_id=u.id
          integration_relations << sr
        end
      end
      integration_relations
    end
  end


  def self.clients
    Rails.cache.fetch("clients", expires_in: CACHE_DURATION) do
      Rails.logger.debug "fetched clients"
      clients=[]
      doc = File.open("./lib/integrations.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//client").each do |node| 
        c=Client.new(node.xpath("systemId").text)
        c.name=node.xpath("systemId").text

        #Exmple Properties
        c.properties=[Property.new("Exampel","true"),Property.new("Ping","Pong")]

        clients << c
      end
      clients.uniq{|c| c.id}
    end
  end

  def self.subscriptions
    Rails.cache.fetch("subscriptions", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched subscriptions"
      doc = File.open("./lib/integrations.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      subscriptions=[]
      doc.xpath(%Q(//client)).each do | node |
        sub=Subscription.new

        s=Integration.new(node.xpath("../../integrationId").text)

        c=Client.new(node.xpath("systemId").text)

        sub.client_id=c.id
        sub.integration_id=s.id
        sub.starts_at=node.xpath("debitStartDate").text
        subscriptions << sub
      end
      subscriptions
    end
  end

  def self.backends
    Rails.cache.fetch("backends", expires_in: CACHE_DURATION) do
      Rails.logger.debug "fetched backends"
      backends=[]
      doc = File.open("./lib/backends.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//backend").each do |node| 
        b=Backend.new(node.xpath("id").text)
        set_text_value("name",b,node)
        b.system_id=node.xpath("systemId").text

        backends << b
      end
      backends.uniq{|b| b.id}
    end
  end

  def self.integration_backends
    Rails.cache.fetch("integration_backends", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched integration backends"
      integration_backends=[]
      doc = File.open("./lib/integration_backends.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//integration").each do |node| 
        s=Integration.new(node.xpath("id").text)
        
        node.xpath("backendId").each do | backendId_node|
          b=Backend.new(backendId_node.text)
          sb=IntegrationBackend.new(s.id,b.id)
          integration_backends << sb
        end
      end
      integration_backends
    end
  end

  def self.systems
    Rails.cache.fetch("systems", expires_in: CACHE_DURATION) do
      Rails.logger.debug "fetched systems"
      systems=[]
      doc = File.open("./lib/systems.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//system").each do |node| 
        b=System.new(node.xpath("id").text)
        set_text_value("name",b,node)

        systems << b
      end
      systems.uniq{|b| b.id}
    end
  end

  def self.contacts
    xml = File.open("./lib/contacts.xml") { |f| Nokogiri::XML(f) }
    contacts=[]
    xml.xpath("/contacts/contact").each do |node|
     c=Contact.new(node.xpath("name").text)
     set_text_value("email",c,node)
     set_text_value("description",c,node)
     set_text_value("phone",c,node)
     set_text_value("tags",c,node)
     node.xpath("on").each do | role_node|
       role_node.xpath("system").each do |system_node|
         s=System.new(system_node.xpath("id").text)
         r=Role.new(c,"system",s.id,system_node.xpath("role").text)
         c.roles << r
       end
       role_node.xpath("integration").each do |integration_node|
         s=Integration.new(integration_node.xpath("id").text)
         r=Role.new(c,"integration",s.id,integration_node.xpath("role").text)
         c.roles << r
       end
       role_node.xpath("backend").each do |backend_node|
         b=Backend.new(backend_node.xpath("id").text)
         r=Role.new(c,"system",b.id,backend_node.xpath("role").text)
         c.roles << r
       end
       role_node.xpath("client").each do |client_node|
         client=Client.new(client_node.xpath("id").text)
         r=Role.new(c,"client",client.id,client_node.xpath("role").text)
         c.roles << r
       end
     end
     contacts << c
    end

    #Make uniq by id and merge roles
    contacts.inject({}) do |uniq,c| 
     if uniq[c.id]
       old=uniq[c.id]
       old.roles.push(*c.roles)
       uniq[c.id]=old
     else
       uniq[c.id]=c
     end
     uniq
    end.map {|k,v| v}
  end


  def self.set_text_value(key,object,node)
    value=node.xpath(key).text
     if !value.blank?
       object.instance_variable_set("@#{key}",value)
     end
  end
end




# class Integration
#   attr_accessor :id,:name,:group
# end
# class Client
#   attr_accessor :id
#   def to_s
#     self.id
#   end
# end
# class Subscription
#   attr_accessor :integration_id,:client_id, :starts_at
#   def to_s
#     "s: #{self.integration_id} c: #{self.client_id}, #{self.starts_at}"
#   end
# end


if __FILE__ == $0
  # puts Backend.integration("getPersonCategory/getPerson") 
  # puts Backend.clients
  puts Backend.client_subscriptions("Y75")
end
