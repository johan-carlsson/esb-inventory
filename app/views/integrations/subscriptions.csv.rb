response.headers["Content-Disposition"] = 'attachment; filename=clients.csv'
CSV.generate do |csv|
  csv << ["Client", "Client since", "Client to"]
  @subscriptions.each do |subscription|
    csv << [
     subscription.client,
     subscription.starts_at,
     subscription.ends_at
    ]
  end
end
