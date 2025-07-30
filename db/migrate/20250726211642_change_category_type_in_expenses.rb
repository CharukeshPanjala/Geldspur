class ChangeCategoryTypeInExpenses < ActiveRecord::Migration[8.0]
  def up
    change_column :expenses, :category, 'integer USING CAST(category AS integer)'
  end

  def down
    change_column :expenses, :category, :string
  end
end
