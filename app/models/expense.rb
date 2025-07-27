# == Schema Information
#
# Table name: expenses
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  amount     :decimal(10, 2)   not null
#  category   :integer          default(6), not null
#  spent_on   :date             not null
#  note       :text
#  user_id    :bigint           not null, foreign key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Expense < ApplicationRecord
  belongs_to :user
  enum :category, { food: 0, transport: 1, entertainment: 2, utilities: 3, health: 4, other: 5, unknown: 6 }

  validates :title, :amount, :category, :spent_on, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
