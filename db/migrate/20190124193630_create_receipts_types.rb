class CreateReceiptsTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
