response.headers["Content-Disposition"] = 'attachment; filename=backends.csv'
CSV.generate do |csv|
  csv << ["Name", "Group", "Number of integrations"]
  @backends.each do |backend|
    csv << [
     backend.name,
     backend.id,
     backend.integration_count
    ]
  end
end
