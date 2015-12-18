response.headers["Content-Disposition"] = 'attachment; filename=integrations.csv'
CSV.generate do |csv|
  csv << ["Name", "Group"]
  @integrations.each do |integration|
    csv << [
     integration.name,
     integration.group
    ]
  end
end
