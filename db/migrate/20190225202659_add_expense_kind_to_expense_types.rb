class AddExpenseKindToExpenseTypes < ActiveRecord::Migration[5.2]
  def change
    add_reference :expense_types, :expense_kind, foreign_key: true
  end
end
