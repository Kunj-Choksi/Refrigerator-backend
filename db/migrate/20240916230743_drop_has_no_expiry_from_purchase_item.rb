class DropHasNoExpiryFromPurchaseItem < ActiveRecord::Migration[7.1]
  def change
    remove_column :purchase_items, :has_no_expiry
  end
end
