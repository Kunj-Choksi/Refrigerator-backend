module PurchaseServices
  module VerifiPurchase
    class Mapper
      def self.call(...)
        new(...).call
      end

      def call
        VerifiMapped.new(mapped_purchase:, mapped_purchase_items:)
      end

      def initialize(verifi_dump:, purchase:)
        @verifi_dump = verifi_dump
        @purchase = purchase
      end

      private

      attr_reader :purchase, :verifi_dump

      def mapped_purchase
        ActiveSupport::HashWithIndifferentAccess.new(
          {
            store_name: verifi_dump['vendor']['name'],
            purchase_date: verifi_dump['date'],
            billing_amount: verifi_dump['total'],
            store_logo: verifi_dump['vendor']['logo'],
            verifi_id: verifi_dump['id'],
            verifi_metadata: verifi_dump.except('line_items')
          }
        )
      end

      def mapped_purchase_items
        verifi_dump['line_items'].map do |line_item|
          ActiveSupport::HashWithIndifferentAccess.new(
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
end
