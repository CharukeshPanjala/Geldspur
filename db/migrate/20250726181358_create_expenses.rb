class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.decimal :amount
      t.string :category
      t.date :spent_on
      t.text :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
