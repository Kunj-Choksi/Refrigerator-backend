module PurchaseServices
  # Returns the most recent item about to expire
  module ItemServices
    #
    # @example
    #   PurchaseServices::ItemServices::ExpiringItem.call
    #
    # @return Purchase::Item
    class ExpiringItem
      def self.call
        purchase_items = Purchase::Item.not_used.with_expirations.order(expiration_date: :asc)

        purchase_items.first
      end
    end
  end
end
