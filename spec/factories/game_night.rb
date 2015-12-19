FactoryGirl.define do
  factory :game_night do
    time Time.zone.now
    location_name Faker::Hipster.words(2)
    location_address Faker::Address.street_name
  end
end
