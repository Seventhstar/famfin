class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.date :date
      t.integer :amount
      t.references :account, foreign_key: true
      t.references :receipts_type, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
