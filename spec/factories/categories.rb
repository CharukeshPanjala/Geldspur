FactoryBot.define do
  factory :category do
    association :user
    sequence(:name) { |n| "Category #{n}" }
    description { Faker::Lorem.sentence }
    category_type { [ "income", "expense" ].sample }
    sequence(:slug) { |n| "category-#{n}" }
  end
end
