class ExpenseRow < ApplicationRecord
  belongs_to :expense_type
  belongs_to :expense

  def expense_type_name
     expense_type.try(:name)
  end
end
