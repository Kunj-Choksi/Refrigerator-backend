json.extract! purchase, :id, :store_name, :billing_amount, :partial_amount, :purchase_type, :purchase_date, :store_logo, :verifi_id, :verifi_metadata, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
