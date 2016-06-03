response.headers["Content-Disposition"] = 'attachment; filename=systems.csv'
CSV.generate(:col_sep => ";") do |csv|
  csv << ["Name", "Group", "Id", "Provides"]
  @systems.each do |system|
    csv << [
     system.name,
     system.group,
     system.id,
     system.provide_count
    ]
  end
end
