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

require "test_helper"

class ExpenseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
