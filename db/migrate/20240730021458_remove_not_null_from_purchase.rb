class RemoveNotNullFromPurchase < ActiveRecord::Migration[7.1]
  def change
    change_column_null :purchases, :store_name, true
    change_column_null :purchases, :billing_amount, true
    change_column_null :purchases, :purchase_date, true
  end
end
