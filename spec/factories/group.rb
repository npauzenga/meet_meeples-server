FactoryGirl.define do
  factory :group do
    name Faker::Hipster.words(2)
    moderator_email Faker::Internet.email
  end
end
