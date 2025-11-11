# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  category_type :string
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  slug          :string
#

class Category < ApplicationRecord
  belongs_to :user

  has_many :expenses, dependent: :nullify
  has_many :incomes, dependent: :nullify
  has_many :budgets, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }, allow_blank: true

  before_save :generate_slug

  scope :find_by_slug, ->(slug) { find_by(slug: slug) }
  scope :ordered, -> { order(:name) }

  def generate_slug
    self.slug = name.parameterize if name.present?
  end

  def formatted_name
    name.titleize
  end

  def expenses_for_user(user)
    expenses.where(user: user)
  end

  def incomes_for_user(user)
    incomes.where(user: user)
  end

  def budgets_for_user(user)
    budgets.where(user: user)
  end

  def total_expenses_for_user(user)
    expenses_for_user(user).sum(:amount)
  end

  def total_income_for_user(user)
    incomes_for_user(user).sum(:amount)
  end

  def as_json_response
    {
      id: id,
      name: name,
      description: description,
      category_type: category_type,
      slug: slug,
      user: {
        id: user.id,
        name: user.first_name + " " + user.last_name
      }
    }
  end
end
