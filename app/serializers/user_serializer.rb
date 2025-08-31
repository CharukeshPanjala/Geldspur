class UserSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :mobile_number, :country, :city

  has_many :expenses
  has_many :incomes
  has_many :budgets
  has_many :categories
end
