class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.string :description
      t.float :amount
      t.string :category
      t.date :expense_date
      t.string :payment_method
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
