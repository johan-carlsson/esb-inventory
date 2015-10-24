class Registry
  require 'nokogiri'

  CACHE_DURATION=10.minutes
  
  def self.services
    Rails.cache.fetch("backend/services", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched services"
      services=[]
      doc = File.open("./lib/services.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//service").each do |node| 
        s=Service.new
        s.identifier=node.xpath("serviceId").text
        s.name=node.xpath("name").text
        s.protocol=node.xpath("protocol").text
        if s.protocol == "http"
          s.format="soap/xml"
           s.properties << Property.new("Format","soap/xml")
           s.properties << Property.new("Protocol","http")
        end
        if s.protocol== "mq"
           s.properties << Property.new("Protocol","mq")
           s.properties << Property.new("Format","xml")
        end
        s.group=node.xpath("group").text
        s.provider_id=Provider.new("I05").id

        #Properties
        s.properties << Property.new("Timeout",1000)
        services << s
      end
      services
    end
  end


  def self.service_relations
    Rails.cache.fetch("service_relations", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched service relations"
      service_relations=[]
      doc = File.open("./lib/services.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//relations").each do |node| 
        s=Service.new
        s.identifier=node.xpath("../serviceId").text
        
        node.xpath("using").each do |using_node|
          u=Service.new
          u.identifier=using_node.xpath("serviceId").text
          sr=ServiceRelation.new
          sr.relation_type="Using"
          sr.service_id=s.id
          sr.related_service_id=u.id
          service_relations << sr
        end

        node.xpath("usedBy").each do |using_node|
          u=Service.new
          u.identifier=using_node.xpath("serviceId").text
          sr=ServiceRelation.new
          sr.relation_type="UsedBy"
          sr.service_id=s.id
          sr.related_service_id=u.id
          service_relations << sr
        end
      end
      service_relations
    end
  end


  def self.clients
    Rails.cache.fetch("backend/clients", expires_in: CACHE_DURATION) do
      Rails.logger.debug "fetched clients"
      clients=[]
      doc = File.open("./lib/services.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//client").each do |node| 
        c=Client.new
        c.identifier=node.xpath("providerId").text
        c.name=node.xpath("providerId").text

        #Properties
        p=Property.new("x","Y")
        c.properties=[Property.new("Timeout",1000),Property.new("Owner","Nisse"),p]

        clients << c
      end
      clients.uniq{|c| c.id}
    end
  end

  def self.subscriptions
    Rails.cache.fetch("backend/subscriptions", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched subscriptions"
      doc = File.open("./lib/services.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      subscriptions=[]
      doc.xpath(%Q(//client)).each do | node |
        sub=Subscription.new

        s=Service.new
        s.identifier=node.xpath("../../serviceId").text

        c=Client.new
        c.identifier=node.xpath("providerId").text

        sub.client_id=c.id
        sub.service_id=s.id
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
      doc = File.open("./lib/services.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//backend").each do |node| 
        b=Backend.new
        b.identifier=node.xpath("id").text
        b.name=node.xpath("name").text
        b.provider_id=node.xpath("providerId").text

        backends << b
      end
      backends.uniq{|b| b.id}
    end
  end

  def self.service_backends
    Rails.cache.fetch("service_backends", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched service backends"
      service_backends=[]
      doc = File.open("./lib/services.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//backend").each do |node| 
        s=Service.new
        s.identifier=node.xpath("../../serviceId").text
        b=Backend.new
        b.identifier=node.xpath("id").text
        sb=ServiceBackend.new
        sb.service_id=s.id
        sb.backend_id=b.id
        service_backends << sb
      end
      service_backends
    end
  end

  def self.providers
    Rails.cache.fetch("providers", expires_in: CACHE_DURATION) do
      Rails.logger.debug "fetched providers"
      providers=[]
      doc = File.open("./lib/providers.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//provider").each do |node| 
        b=Provider.new(node.xpath("id").text)
        b.name=node.xpath("name").text

        providers << b
      end
      providers.uniq{|b| b.id}
    end
  end


end




# class Service
#   attr_accessor :id,:name,:group
# end
# class Client
#   attr_accessor :id
#   def to_s
#     self.id
#   end
# end
# class Subscription
#   attr_accessor :service_id,:client_id, :starts_at
#   def to_s
#     "s: #{self.service_id} c: #{self.client_id}, #{self.starts_at}"
#   end
# end


if __FILE__ == $0
 # puts Backend.service("getPersonCategory/getPerson") 
 # puts Backend.clients
 puts Backend.client_subscriptions("Y75")
end
