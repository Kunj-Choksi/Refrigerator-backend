module PurchaseServices
  class SavePurchase
    def self.call(...)
      new(...).call
    end

    def call
      false unless @purchase.save!

      VerifiPurchase::Transform.call(purchase: @purchase)

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
      @purchase.assign_attributes(@params)
    end
  end
end
