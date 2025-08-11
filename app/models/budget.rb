# == Schema Information
#
# Table name: budgets
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  amount      :float
#  start_date  :date
#  end_date    :date
#  user_id     :integer          not null
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true, length: { maximum: 100 }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :validate_dates
  validates :user, presence: true
  validates :category, presence: true

  def validate_dates
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "must be after the start date") if end_date < start_date
  end

  def days_in_budget
    (end_date - start_date).to_i
  end

  def active_budget?
    start_date <= Date.current && end_date >= Date.current
  end

  def formatted_amount
    sprintf("%.2f", amount)
  end

  def total_spent
    user.expenses.where(category: category).sum(:amount)
  end

  def remaining_budget
    amount - total_spent
  end

  def overrun?
    remaining_budget < 0
  end

  def self.monthly_budget(user, month)
    where(user: user)
      .where("extract(month from start_date) = ? AND extract(year from start_date) = ?", month, Date.current.year)
  end

  def self.yearly_budget(user, year)
    where(user: user)
      .where("extract(year from start_date) = ?", year)
  end

  scope :by_user, ->(user) { where(user: user) }
  scope :by_category, ->(category) { where(category: category) }
  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.current, Date.current) }
  scope :upcoming, -> { where("start_date > ?", Date.current) }
  scope :past, -> { where("end_date < ?", Date.current) }
end
