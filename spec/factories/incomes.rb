FactoryBot.define do
  factory :income do
    association :user
    association :category
    title { "Salary" }
    amount { rand(100..5000).to_f }
    payment_method { [ "bank", "cash", "online" ].sample }
    income_date { Date.today }
  end
end
