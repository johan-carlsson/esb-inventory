class IntegrationRelation
  include ActiveModel::Model
  attr_accessor :integration_id, :relation_type, :related_integration_id

  def self.all
    Registry.integration_relations
  end

  def self.find_all_by_integration_id(id)
   a= all.find_all {|s| s.integration_id == id}
   b= all.find_all {|s| s.related_integration_id == id}.map{|s| s.flip }
   #TODO Remove duplicates
   a+b
  end

  def integration
    Integration.find_by_id(self.integration_id)    
  end

  def related_integration
    Integration.find_by_id(self.related_integration_id)    
  end

  def flip
     if relation_type == "Use"
       t=integration_id
       self.integration_id=related_integration_id
       self.related_integration_id=t
       self.relation_type="UsedBy"
     elsif relation_type == "UsedBy"
       t=integration_id
       self.integration_id=related_integration_id
       self.related_integration_id=t
       self.relation_type="Use"
     end
     self
  end

  def persisted?
    true
  end
end
