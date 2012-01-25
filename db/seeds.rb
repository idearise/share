# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

platforms = Platform.create([
  { name: "Web", display_order: 1 },
  { name: "Android", display_order: 2 },
  { name: "iOS", display_order: 3 },
  { name: "Windows Phone", display_order: 4 }
])


app = App.new(
  :name => "example.com", 
  :website => "http://www.example.com",
  :about => "This is just an example of how apps in inthisapp might be created",
  :thanks_to => "the internet gods",
  :platforms => platforms.values_at(0, 1)
)
app.id = 1
app.save!
