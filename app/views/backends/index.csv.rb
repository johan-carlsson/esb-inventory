response.headers["Content-Disposition"] = 'attachment; filename=backends.csv'
CSV.generate(:col_sep => ";") do |csv|
  csv << ["Name", "Group", "Id", "Number of integrations"]
  @backends.each do |backend|
    csv << [
     backend.name,
     backend.group,
     backend.id,
     backend.integration_count
    ]
  end
end
