class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.string :store_name, null: false
      t.float :billing_amount, null: false
      t.float :partial_amount
      t.string :purchase_type
      t.date :purchase_date, null: false
      t.string :store_logo, default: 'https://storage.cloud.google.com/refrigerator_receipts/supermarket-logo.jpeg'
      t.string :verifi_id
      t.jsonb :verifi_metadata

      t.timestamps
    end
  end
end
