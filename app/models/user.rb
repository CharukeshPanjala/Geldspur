# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  mobile_number   :string
#  country         :string
#  city            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    has_many :expenses
    has_many :incomes
    has_many :budgets
    has_many :categories

    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :mobile_number, presence: true, format: { with: /\A\+?\d{10,15}\z/, message: "must be a valid phone number" }

    has_secure_password


    def full_name
        "#{first_name} #{last_name}"
    end

    def formatted_mobile
        mobile_number.gsub(/(\+?\d{1,3})(\d{3})(\d{3})(\d+)/, '\1 \2 \3 \4')
    end

    def total_expenses
        expenses.sum(:amount)
    end

    def total_income
        incomes.sum(:amount)
    end

    def net_balance
        total_income - total_expenses
    end
end
