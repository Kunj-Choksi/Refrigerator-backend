module PurchaseServices
  module VerifiPurchase
    class Mapper
      def self.call(...)
        new(...).call
      end

      def call
        VerifiMapped.new(mapped_purchase:, mapped_purchase_items:)
      end

      private

      attr_reader :verifi_dump, :purchase

      def initialize(verifi_dump:, purchase:)
        @verifi_dump = verifi_dump
        @purchase = purchase
      end

      def mapped_purchase
        HashWithIndifferentAccess.new(
          {
            store_name: verifi_dump['vendor']['name'],
            billing_amount: verifi_dump['total'],
            store_logo: verifi_dump['vendor']['vendor_logo'],
            verifi_id: verifi_dump['id'],
            verifi_metadata: verifi_dump.except('line_items')
          }
        )
      end

      def mapped_purchase_items
        mapped_purchase_items = []
        verifi_dump['line_items'].each do |line_item|
          mapped_purchase_items << purchase_item(line_item)
        end
        mapped_purchase_items
      end

      def purchase_item(line_item)
        HashWithIndifferentAccess.new(
          {
            purchase_id: purchase.id,
            name: line_item['description'],
            price: line_item['total'],
            item_type: verifi_dump['type'],
            verifi_id: verifi_dump['id'],
            verifi_metadata: line_item
          }
        )
      end
    end
  end
end
