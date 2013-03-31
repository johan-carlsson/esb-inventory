# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Service.create([{name: 'getPerson', category: "Person"},{name:  "searchEstate",category: "Estate"}] )
Consumer.create([{name:  "HALO"},{name:  "H82"}] )
Provider.create([{name: "S70"},{name: "KIS"}] )
Subscription.create([{service_name: "getPerson",consumer_name: "HALO"},{service_name: "searchEstate", consumer_name: "H82"}] )
