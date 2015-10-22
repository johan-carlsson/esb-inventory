class ServiceRelation
  include ActiveModel::Model
  attr_accessor :service_id, :relation_type, :related_service_id

  def self.all
    Registry.service_relations
  end

  def self.find_all_by_service_id(id)
   a= all.find_all {|s| s.service_id == id}
   b= all.find_all {|s| s.related_service_id == id}.map{|s| s.flip }
   #TODO Remove duplicates
   a+b
  end

  def service
    Service.find_by_id(self.service_id)    
  end

  def related_service
    Service.find_by_id(self.related_service_id)    
  end

  def flip
     if relation_type == "Using"
       t=service_id
       self.service_id=related_service_id
       self.related_service_id=t
       self.relation_type="UsedBy"
     elsif relation_type == "UsedBy"
       t=service_id
       self.service_id=related_service_id
       self.related_service_id=t
       self.relation_type="Using"
     end
     self
  end

  def persisted?
    true
  end
end
