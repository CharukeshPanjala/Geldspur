FactoryBot.define do
  factory :budget do
    association :user
    association :category

    name { "Monthly Budget" }
    description { "Budget for monthly spending" }
    amount { rand(100..1000) }
    start_date { Date.today.beginning_of_month }
    end_date { Date.today.end_of_month }
  end
end
