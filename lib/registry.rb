class Registry
  require 'nokogiri'

  CACHE_DURATION=0.minutes
  
  def self.services
    Rails.cache.fetch("backend/services", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched services"
      services=[]
      doc = File.open("./lib/services.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//service").each do |node| 
        s=Service.new
        s.id=node.xpath("serviceId").text
        s.name=node.xpath("name").text
        s.protocol=node.xpath("protocol").text
        if s.protocol == "http"
          s.format="soap/xml"
        end
        if s.protocol== "mq"
          s.format="xml"
        end
        s.group=node.xpath("group").text
        services << s
      end
      services
    end
  end


  def self.consumers
    Rails.cache.fetch("backend/consumers", expires_in: CACHE_DURATION) do
      Rails.logger.debug "fetched consumers"
      consumers=[]
      doc = File.open("./lib/services.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      doc.xpath("//consumer").each do |node| 
        c=Consumer.new
        c.id=node.xpath("systemId").text
        c.name=node.xpath("systemId").text
        consumers << c
      end
      consumers.uniq{|c| c.id}
    end
  end


  def self.subscriptions
    Rails.cache.fetch("backend/subscriptions", expires_in: CACHE_DURATION) do
      Rails.logger.debug "Fetched subscriptions"
      doc = File.open("./lib/services.xml") { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!

      subscriptions=[]
      doc.xpath(%Q(//consumer)).each do | node |
        sub=Subscription.new
        sub.consumer_id=node.xpath("systemId").text
        sub.service_id=node.xpath("../../serviceId").text
        sub.starts_at=node.xpath("debitStartDate").text
        subscriptions << sub
      end
      subscriptions
    end
  end

end

# class Service
#   attr_accessor :id,:name,:group
# end
# class Consumer
#   attr_accessor :id
#   def to_s
#     self.id
#   end
# end
# class Subscription
#   attr_accessor :service_id,:consumer_id, :starts_at
#   def to_s
#     "s: #{self.service_id} c: #{self.consumer_id}, #{self.starts_at}"
#   end
# end


if __FILE__ == $0
 # puts Backend.service("getPersonCategory/getPerson") 
 # puts Backend.consumers
 puts Backend.consumer_subscriptions("Y75")
end
