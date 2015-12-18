response.headers["Content-Disposition"] = 'attachment; filename=integrations.csv'
CSV.generate(:col_sep => ";") do |csv|
  csv << ["Integration", "Client since", "Client to"]
  @subscriptions.each do |subscription|
    csv << [
     subscription.integration,
     subscription.starts_at,
     subscription.ends_at
    ]
  end
end
