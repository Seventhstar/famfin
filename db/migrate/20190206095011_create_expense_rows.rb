class CreateExpenseRows < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_rows do |t|
      t.references :expense, foreign_key: true
      t.references :expense_type, foreign_key: true
      t.integer :amount
      t.string :comment

      t.timestamps
    end
  end
end
