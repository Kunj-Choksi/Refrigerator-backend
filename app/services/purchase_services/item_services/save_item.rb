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
        @purchase_item.name = params[:name] if params[:name].present?
        @purchase_item.price = params[:price] if params[:price].present?
        @purchase_item.quantity = params[:quantity] if params[:quantity].present?
        @purchase_item.unit = params[:unit] if params[:unit].present?
        @purchase_item.expiration_date = params[:expiration_date] if params[:expiration_date].present?
        @purchase_item.has_no_expiry = params[:has_no_expiry] if params[:has_no_expiry].present?
        @purchase_item.used = params[:used] if params[:used].present?
      end
    end
  end
end
