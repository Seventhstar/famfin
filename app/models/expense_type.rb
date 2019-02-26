class ExpenseType < ApplicationRecord
  belongs_to :parent, class_name: 'ExpenseType', foreign_key: "parent_id", optional: true
  belongs_to :expense_kind
end
