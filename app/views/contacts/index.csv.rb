response.headers["Content-Disposition"] = 'attachment; filename=contacts.csv'
CSV.generate do |csv|
  csv << ["Name", "Email", "Phone"]
  @contacts.each do |contact|
    csv << [
     contact.name,
     contact.email,
     contact.phone
    ]
  end
end
