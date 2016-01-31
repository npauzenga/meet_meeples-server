FactoryGirl.define do
  factory :game_night do
    name Faker::Team.name
    time { rand(7).days.from_now.to_date }
    location_name Faker::Company.name
    location_address Faker::Address.street_name
  end
end
