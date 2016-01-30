require 'faker'

# create users
5.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              city: Faker::Address.city,
              state: Faker::Address.state,
              country: Faker::Address.country,
              password: "helloworld",
              email_confirmed: true)
end

# create game_night
5.times do
  GameNight.create(name: Faker::Hipster.words(2),
                   time: rand(7).days.from_now.to_date,
                   location_name: Faker::Hipster.words(2),
                   location_address: Faker::Address.street_name)
end

# create groups
5.times do
  Group.create(name: Faker::Hipster.words(2))
end

puts "#{User.count} Users created"
puts "#{GameNight.count} GameNights created"
puts "#{Group.count} Groups created"
