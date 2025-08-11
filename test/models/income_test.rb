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

require "test_helper"

class IncomeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
