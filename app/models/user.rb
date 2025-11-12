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
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :string           default("user")
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :expenses
    has_many :incomes
    has_many :budgets
    has_many :categories

    # Validations
    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :mobile_number, presence: true, format: { with: /\A\+?\d{10,15}\z/, message: "must be a valid phone number" }


    def admin?
        role == "admin"
    end

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

    def as_json_response
        {
            id: id,
            first_name: first_name,
            last_name: last_name,
            full_name: full_name,
            email: email,
            mobile_number: formatted_mobile,
            country: country,
            city: city,
            total_expenses: total_expenses,
            total_income: total_income,
            net_balance: net_balance
        }
    end
end
