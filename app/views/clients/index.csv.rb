response.headers["Content-Disposition"] = 'attachment; filename=clients.csv'
CSV.generate(:col_sep => ";") do |csv|
  csv << ["Name", "Group", "Id", "Number of integrations"]
  @clients.each do |client|
    csv << [
     client.name,
     client.group,
     client.id,
     client.subscriptions.count
    ]
  end
end
