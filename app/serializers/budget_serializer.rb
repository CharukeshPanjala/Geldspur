class BudgetSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :amount, :start_date, :end_date, :user, :category
end
