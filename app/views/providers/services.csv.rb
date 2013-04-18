response.headers["Content-Disposition"] = 'attachment; filename=services.csv'
CSV.generate do |csv|
  csv << ["Name", "Category", "Number of consumers"]
  @services.each do |service|
    csv << [
     service.name,
     service.category,
     service.subscriptions.count
    ]
  end
end
