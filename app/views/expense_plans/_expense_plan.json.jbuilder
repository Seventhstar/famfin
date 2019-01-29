json.extract! expense_plan, :id, :date, :amount, :expense_type_id, :comment, :created_at, :updated_at
json.url expense_plan_url(expense_plan, format: :json)
