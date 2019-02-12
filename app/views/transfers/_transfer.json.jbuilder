json.extract! transfer, :id, :date, :amount, :account_from_id, :account_to_id, :comment, :created_at, :updated_at
json.url transfer_url(transfer, format: :json)
