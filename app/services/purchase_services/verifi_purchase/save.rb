module PurchaseServices
  module VerifiPurchase
    class Save
      def self.call(...)
        new(...).call
      end

      def call
        update_purchase

        save_purchase_items
      end

      private

      attr_reader :mapped_purchase, :mapped_purchase_items, :purchase

      def initialize(mapped_purchase:, mapped_purchase_items:, purchase:)
        @mapped_purchase = mapped_purchase
        @mapped_purchase_items = mapped_purchase_items
        @purchase = purchase
      end

      def update_purchase
        PurchaseServices::UpdatePurchase.call(purchase: purchase, params: mapped_purchase)
      end

      def save_purchase_items
        mapped_purchase_items.each do |purchase_item|
          PurchaseServices::ItemServices::SaveItem.call(purchase_item: Purchase::Item.new, params: purchase_item)
        end
      end
    end
  end
end
