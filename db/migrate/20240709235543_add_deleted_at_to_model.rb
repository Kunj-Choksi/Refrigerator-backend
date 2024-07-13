class AddDeletedAtToModel < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :deleted_at, :date
    add_column :purchase_items, :deleted_at, :date
  end
end
