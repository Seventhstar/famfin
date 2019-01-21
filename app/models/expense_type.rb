class ExpenseType < ApplicationRecord
  belongs_to :parent, class_name: 'ExpenseType', foreign_key: "parent_id", optional: true
end
