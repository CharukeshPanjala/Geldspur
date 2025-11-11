# == Schema Information
#
# Table name: incomes
#
#  id             :integer          not null, primary key
#  title          :string
#  description    :text
#  amount         :float
#  income_date    :date
#  payment_method :string
#  user_id        :integer          not null
#  category_id    :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Income < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :category

  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :amount, presence: true
  validates :income_date, presence: true
  validates :user, presence: true
  validates :category, presence: true

  # Scopes
  scope :by_user, ->(user) { where(user: user) }

  scope :by_month, ->(month, year = Date.current.year) {
    where(
      "extract(month from income_date) = ? AND extract(year from income_date) = ?",
      month, year
    )
  }

  scope :by_year, ->(year = Date.current.year) {
    where("extract(year from income_date) = ?", year)
  }

  # Class Methods
  def self.monthly_income(user, month)
    by_user(user).by_month(month)
  end

  def self.yearly_income(user, year = Date.current.year)
    by_user(user).by_year(year)
  end

  # Public API (used by controllers)
  def as_json_response
    {
      id: id,
      title: title,
      description: description,
      amount: amount,
      formatted_amount: formatted_amount,
      income_date: income_date,
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

  # Public helpers
  def total_amount
    amount
  end

  private

  # Internal helpers (not meant for controllers)
  def formatted_date
    income_date.strftime("%B %d, %Y")
  end

  def formatted_amount
    sprintf("%.2f", amount)
  end

  def user_name
    user.first_name + " " + user.last_name
  end
end
