module PurchaseServices
  module VerifiPurchase
    class Transform
      def self.call(...)
        new(...).call
      end

      def call
        verifi_dump

        verifi_mapped

        save_data
      end

      private

      attr_reader :purchase

      def initialize(purchase:)
        @purchase = purchase
      end

      def verifi_dump
        @verifi_dump ||= VerifiUtil::Fetch.call(purchase_receipt)
      end

      def verifi_mapped
        @verifi_mapped ||= Mapper.call(verifi_dump: @verifi_dump, purchase:)
      end

      def save_data
        Save.call(
          mapped_purchase: @verifi_mapped.mapped_purchase,
          mapped_purchase_items: @verifi_mapped.mapped_purchase_items,
          purchase:
        )
      end

      def purchase_receipt
        @purchase.purchase_receipt.url
      end
    end
  end
end
