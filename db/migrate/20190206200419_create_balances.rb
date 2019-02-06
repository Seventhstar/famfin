class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.date :date
      t.string :amount
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
