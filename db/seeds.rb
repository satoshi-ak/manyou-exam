# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(
#   name: 'ak',
#   email: 'aktesttest@test.com',
#   password: 'testtest',
#   password_confirmation: 'testtest',
#   admin: 'true',
# )

# 10.times do |n|
#   name = Faker::Games::Pokemon.name
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(name: name,
#                email: email,
#                password: password,
#                admin: false,
#                )
# end

10.times do |n|
  Label.create!(name: "label_0#{n} ")
end
10.times do |n|
  User.all.each do |user|
    rand1 = rand(0..2)
    status = ["未着手", "着手中", "完了"]
    user.tasks.create!(
      name: "Task_0#{n}",
      description: "Conten_0#{n}",
      expiration_date: Date.today+rand1,
      status: status[rand1],
      priority: rand1,
    )
  end
end