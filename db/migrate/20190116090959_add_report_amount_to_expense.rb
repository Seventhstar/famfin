class AddReportAmountToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :report_amount, :integer, default: 0
  end
end
