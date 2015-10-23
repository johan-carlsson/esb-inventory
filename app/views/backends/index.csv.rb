response.headers["Content-Disposition"] = 'attachment; filename=consumers.csv'
CSV.generate do |csv|
  csv << ["Name", "Id", "Number of services"]
  @consumers.each do |consumer|
    csv << [
     consumer.name,
     consumer.id,
     consumer.subscriptions.count
    ]
  end
end
