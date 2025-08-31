class IncomeSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :amount, :income_date, :payment_method, :user, :category
end
