class AddColsToPurchaseItem < ActiveRecord::Migration[7.1]
  def change
    add_column :purchase_items, :used, :boolean, default: false
    add_column :purchase_items, :has_no_expiry, :boolean, default: false
  end
end
