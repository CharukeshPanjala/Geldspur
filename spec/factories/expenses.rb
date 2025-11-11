FactoryBot.define do
  factory :expense do
    association :user
    association :category

    title { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    amount { rand(10..300).to_f }
    expense_date { Date.today }
    payment_method { ["cash", "card", "online"].sample }
  end
end
