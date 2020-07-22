50.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "123456"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password
               )
end