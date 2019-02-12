class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.date :date
      t.string :amount
      t.references :account, foreign_key: true
      t.integer :account_to_id
      t.string :comment

      t.timestamps
    end
  end
end
