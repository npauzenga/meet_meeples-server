FactoryGirl.define do
  factory :confirmed_user, class: User do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    city Faker::Address.city
    state Faker::Address.state
    country Faker::Address.country
    password "helloworld"
    email_confirmed true
    password "helloworld"
  end

  factory :unconfirmed_user, class: User do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    city Faker::Address.city
    state Faker::Address.state
    country Faker::Address.country
    password "helloworld"
    email_confirmed false
  end
end
