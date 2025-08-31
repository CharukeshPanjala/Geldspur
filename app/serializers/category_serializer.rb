class CategorySerializer
  include JSONAPI::Serializer
  attributes :name, :description, :category_type, :slug, :user

  has_many :expenses
  has_many :incomes
  has_many :budgets
end
