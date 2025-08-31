class ExpenseSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :amount, :expense_date, :payment_method, :user, :category
end
