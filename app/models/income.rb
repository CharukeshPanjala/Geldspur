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
  belongs_to :user
  belongs_to :category


  validates :title, presence: true, length: { maximum: 100 }
  validates :amount, presence: true
  validates :income_date, presence: true
  validates :user, presence: true
  validates :category, presence: true

  def total_amount
    amount
  end

  def formatted_date
    income_date.strftime("%B %d, %Y")
  end

  def formatted_amount
    sprintf("%.2f", amount)
  end

  def self.monthly_income(user, month)
    where(user: user)
      .where("extract(month from income_date) = ? AND extract(year from income_date) = ?", month, Date.current.year)
  end

  def self.yearly_income(user, year = Date.current.year)
    where(user: user)
      .where("extract(year from income_date) = ?", year)
  end

  scope :by_user, ->(user) { where(user: user) }
  scope :by_month, ->(month, year = Date.current.year) {
    where("extract(month from income_date) = ? AND extract(year from income_date) = ?", month, year)
  }
  scope :by_year, ->(year = Date.current.year) {
    where("extract(year from income_date) = ?", year)
  }
end
