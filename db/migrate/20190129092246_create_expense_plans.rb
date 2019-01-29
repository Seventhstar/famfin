class CreateExpensePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_plans do |t|
      t.date :date
      t.integer :amount
      t.references :expense_type, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
