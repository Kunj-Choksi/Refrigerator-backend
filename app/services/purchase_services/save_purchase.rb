module PurchaseServices
  class SavePurchase
    def self.call(...)
      new(...).call
    end

    def call
      false unless @purchase.save!

      VerifiPurchase::Transform.call(purchase: @purchase) if @purchase.purchase_receipt.url

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
      @purchase.assign_attributes(
        store_name: params[:store_name],
        billing_amount: params[:billing_amount],
        purchase_date: params[:purchase_date],
        purchase_receipt: params[:purchase_receipt]
      )
    end
  end
end
