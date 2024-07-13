module PurchaseServices
  class UpdatePurchase
    def self.call(...)
      new(...).call
    end

    def call
      false unless @purchase.save!
      true
    end

    private

    attr_reader :purchase, :params

    def initialize(purchase:, params:)
      @purchase = purchase
      @params = params

      assign_attributes
    end

    def assign_attributes
      @purchase.assign_attributes(params)
    end
  end
end
