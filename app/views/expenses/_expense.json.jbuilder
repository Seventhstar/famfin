json.extract! expense, :id, :date, :shop_id, :amount, :account_id, :expense_type_id, :user_id, :comment, :created_at, :updated_at
json.url expense_url(expense, format: :json)
