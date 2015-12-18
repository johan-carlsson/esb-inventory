response.headers["Content-Disposition"] = 'attachment; filename=systems.csv'
CSV.generate do |csv|
  csv << ["Name", "Id", "Provides"]
  @systems.each do |system|
    csv << [
     system.name,
     system.id,
     system.provide_count
    ]
  end
end
