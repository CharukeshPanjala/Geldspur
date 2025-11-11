FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    email { Faker::Internet.unique.email }
    mobile_number { "+49#{Faker::Number.number(digits: 10)}" }
    country { "Germany" }
    city { "Berlin" }
    password { "password123" }
  end
end
