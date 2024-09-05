module PurchaseServices
  module ItemServices
    class SaveItem
      def self.call(...)
        new(...).call
      end

      def initialize(purchase_item:, params:)
        @purchase_item = purchase_item
        @params = params

        assign_attributes
      end

      def call
        @purchase_item.save!
      end

      private

      attr_reader :purchase_item, :params

      def assign_attributes
        @purchase_item.assign_attributes(
          name: params[:name],
          price: params[:price],
          quantity: params[:quantity],
          unit: params[:unit],
          expiration_date: params[:expiration_date],
          has_no_expiry: params[:has_no_expiry]
        )
      end
    end
  end
end
