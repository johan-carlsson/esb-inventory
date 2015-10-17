response.headers["Content-Disposition"] = 'attachment; filename=services.csv'
CSV.generate do |csv|
  csv << ["Name", "Group", "Number of consumers"]
  @services.each do |service|
    csv << [
     service.name,
     service.group,
     service.subscriptions.count
    ]
  end
end
