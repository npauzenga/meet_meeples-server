FactoryGirl.define do
  factory :game_night do
    name Faker::Hipster.words(2)
    time { rand(7).days.from_now.to_date }
    location_name Faker::Hipster.words(2)
    location_address Faker::Address.street_name
  end
end
