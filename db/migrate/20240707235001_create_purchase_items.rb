class CreatePurchaseItems < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_items do |t|
      t.references :purchase, foreign_key: true
      t.string :name
      t.float :price
      t.date :expiration_date
      t.float :quantity
      t.string :unit
      t.string :item_type
      t.string :verifi_id
      t.json :verifi_metadata

      t.timestamps
    end
  end
end
