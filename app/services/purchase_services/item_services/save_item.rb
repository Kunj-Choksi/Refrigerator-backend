module PurchaseServices
  module ItemServices
    class SaveItem
      def self.call(...)
        new(...).call
      end

      def call
        false unless @purchase_item.save

        true
      end

      private

      attr_reader :purchase_item, :params

      def initialize(purchase_item:, params:)
        @purchase_item = purchase_item
        @params = params

        assign_attributes
      end

      def assign_attributes
        @purchase_item.assign_attributes(params)
      end
    end
  end
end
