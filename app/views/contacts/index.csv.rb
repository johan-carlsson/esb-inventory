response.headers["Content-Disposition"] = 'attachment; filename=clients.csv'
CSV.generate do |csv|
  csv << ["Name", "Id", "Number of integrations"]
  @clients.each do |client|
    csv << [
     client.name,
     client.id,
     client.subscriptions.count
    ]
  end
end
