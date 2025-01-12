class RemoveColumnsFromPurchaseItem < ActiveRecord::Migration[7.2]
  def change
    remove_column :purchase_items, :unit
    remove_column :purchase_items, :quantity
  end
end
