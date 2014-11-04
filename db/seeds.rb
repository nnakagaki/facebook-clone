# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.free_email, password_digest: Faker::Internet.password(10, 20), profile_pic_mini_url: Faker::Avatar.image)
end

User.create(first_name: "King", last_name: "Kong", email: "kingkong", password: "kingkong")
