module PurchaseServices
  class SavePurchase
    def self.call(...)
      new(...).call
    end

    def call
      return false unless purchase.save!

      save_verifi
      true
    end

    def initialize(purchase:, params:)
      @purchase = purchase
      @params = params

      assign_attributes
    end

    private

    attr_reader :purchase, :params

    def assign_attributes
      purchase.store_name = params[:store_name] if params[:store_name].present?
      purchase.billing_amount = params[:billing_amount] if params[:billing_amount].present?
      purchase.purchase_date = params[:purchase_date] if params[:purchase_date].present?
      purchase.purchase_receipt = params[:purchase_receipt] if params[:purchase_receipt]
    end

    def save_verifi
      return if purchase.verifi_metadata.present? || !purchase.purchase_receipt.url

      VerifiPurchase::Transform.call(purchase:)
    end
  end
end
