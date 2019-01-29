class ExpensePlan < ApplicationRecord
  belongs_to :expense_type

  def expense_type_name()
    expense_type.try(:name)
  end

end
