response.headers["Content-Disposition"] = 'attachment; filename=provides.csv'
CSV.generate(:col_sep => ";") do |csv|
  csv << ["Type", "Name"]
  @provides.each do |provide|
    csv << [
     provide.class,
     provide.name,
    ]
  end
end
