response.headers["Content-Disposition"] = 'attachment; filename=contacts.csv'
CSV.generate(:col_sep => ";") do |csv|
  csv << ["Contact", "Email","Role"]
  @roles.each do |role|
    csv << [
     role.contact,
     role.email,
     role.name
    ]
  end
end
