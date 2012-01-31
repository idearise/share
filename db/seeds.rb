platforms = Platform.create([
  { name: "Web", display_order: 1 },
  { name: "Android", display_order: 2 },
  { name: "iOS", display_order: 3 },
  { name: "Windows Phone", display_order: 4 }
])

user1 = User.new
user1.nickname = Forgery(:name).first_name
user1.name = user1.nickname + " " + Forgery(:name).last_name
user1.email = Forgery(:email).address
user1.save

user2 = User.new
user2.nickname = Forgery(:name).first_name
user2.name = user2.nickname + " " + Forgery(:name).last_name
user2.email = Forgery(:email).address
user2.save

user3 = User.new
user3.nickname = Forgery(:name).first_name
user3.name = user3.nickname + " " + Forgery(:name).last_name
user3.email = Forgery(:email).address
user3.save

user4 = User.new
user4.nickname = Forgery(:name).first_name
user4.name = user4.nickname + " " + Forgery(:name).last_name
user4.email = Forgery(:email).address
user4.save

# FIXME Tried to use find_or_initialize_by_name instead of App.new to work around a weird
# validates_uniqueness_of error, but there's still an issue with creating apps 2 to 4!
app1 = App.find_or_initialize_by_name("example.com")
app1.website = "www.example.com"
app1.about = "This is just an example of how apps in inthisapp might be created"
app1.platforms = platforms.values_at(0, 1)
app1.user_id = user1.id
# app1.id = 1
app1.save_new_by(user1.id, '127.0.0.1')

app2 = App.find_or_initialize_by_name("Android app") 
app2.website = "www.android.com"
app2.about = "Android example app description needs to be at least 32 characters in length!"
app2.platforms = platforms.values_at(0, 1)
app2.user_id = user2.id
# app2.id = 2
app2.save_new_by(user2.id, '127.0.0.1')

app3 = App.find_or_initialize_by_name("iOS app")
app3.website = "www.apple.com"
app3.about = "iOS example app description needs to be at least 32 characters in length!"
app3.platforms = platforms.values_at(0, 2)
app3.user_id = user3.id
# app3.id = 3
app3.save_new_by(user3.id, '127.0.0.1')

app4 = App.find_or_initialize_by_name("Windows Phone app")
app4.website = "www.microsoft.com"
app4.about = "Windows Phone app example description needs to be at least 32 characters in length!"
app4.platforms = platforms.values_at(0, 3)
app4.user_id = user4.id
# app4.id = 4
app4.save_new_by(user4.id, '127.0.0.1')
