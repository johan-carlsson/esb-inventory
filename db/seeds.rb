# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Service.create([{name: 'getPerson', category: "Person"},{name:  "searchComputer",category: "Hardware"}] )
Consumer.create([{name:  "Twitter"},{name:  "MacRumors"}] )
Provider.create([{name: "Apple"},{name: "Facebook"}] )
Subscription.create([{service_name: "getPerson",consumer_name: "Twitter"},{service_name: "searchComputer", consumer_name: "MacRumors"}] )
User.create({:name => "test",:password =>"test",:password_confirmation => "test"})
