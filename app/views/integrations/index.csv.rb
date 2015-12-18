response.headers["Content-Disposition"] = 'attachment; filename=integrations.csv'
CSV.generate do |csv|
  csv << ["Name", "Group", "Type", "Number of clients"]
  @integrations.each do |integration|
    csv << [
     integration.name,
     integration.group,
     integration.type,
     integration.subscriptions.count
    ]
  end
end
