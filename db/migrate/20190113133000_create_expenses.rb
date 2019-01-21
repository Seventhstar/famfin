class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.date :date
      t.references :shop, foreign_key: true
      t.integer :amount
      t.references :account, foreign_key: true
      t.references :expense_type, foreign_key: true
      t.references :user, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
