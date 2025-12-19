class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    total_income = current_user.incomes.sum(:amount)
    total_expense = current_user.expenses.sum(:amount)
    balance = total_income - total_expense

    render json: {
      total_income: total_income,
      total_expense: total_expense,
      balance: balance
    }
  end
end
