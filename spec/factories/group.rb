FactoryGirl.define do
  factory :group do
    name Faker::Team.name
    city Faker::Address.city
    state Faker::Address.state
    country Faker::Address.country
    facebook Faker::Internet.url("facebook.com")
    twitter Faker::Internet.url("twitter.com")
  end
end
