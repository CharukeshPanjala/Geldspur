# == Schema Information
#
# Table name: expenses
#
#  id             :integer          not null, primary key
#  title          :string
#  description    :string
#  amount         :float
#  expense_date   :date
#  payment_method :string
#  user_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :integer          not null
#

class Expense < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :category

  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :expense_date, presence: true
  validates :payment_method, presence: true
  validates :user, presence: true
  validates :category, presence: true

  # Scopes
  scope :by_user, ->(user) { where(user: user) }
  scope :by_month, ->(month, year = Date.current.year) {
    where("extract(month from expense_date) = ? AND extract(year from expense_date) = ?", month, year)
  }
  scope :by_year, ->(year = Date.current.year) {
    where("extract(year from expense_date) = ?", year)
  }

  def total_amount
    amount
  end

  def self.monthly_expenses(user, month)
    where(user: user)
      .where("extract(month from expense_date) = ? AND extract(year from expense_date) = ?", month, Date.current.year)
  end

  def self.total_expenses(user, start_date, end_date)
    where(user: user)
      .where(expense_date: start_date..end_date)
      .sum(:amount)
  end

  def recent?
    expense_date >= 7.days.ago.to_date
  end

  def as_json_response
    {
      id: id,
      title: title,
      description: description,
      amount: amount,
      formatted_amount: formatted_amount,
      expense_date: expense_date,
      formatted_date: formatted_date,
      payment_method: payment_method,
      category: {
        id: category.id,
        name: category.name
      },
      user: {
        id: user.id,
        name: user_name
      }
    }
  end

  private

  def formatted_date
    expense_date.strftime("%B %d, %Y")
  end

  def formatted_amount
    sprintf("%.2f", amount)
  end

  def user_name
    user.first_name + " " + user.last_name
  end
end
