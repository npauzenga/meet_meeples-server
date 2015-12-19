FactoryGirl.define do
  factory :group do
    name Faker::Hipster.words(2)
  end
end
