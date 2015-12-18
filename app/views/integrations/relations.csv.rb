response.headers["Content-Disposition"] = 'attachment; filename=relations.csv'
CSV.generate(:col_sep => ";") do |csv|
  csv << ["Relation", "Integration", "Description"]
  @relations.each do |relation|
    csv << [
     relation.relation_type,
     relation.related_integration,
     relation.description
    ]
  end
end
