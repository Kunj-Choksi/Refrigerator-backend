class VerifiMapped
  attr_reader :mapped_purchase, :mapped_purchase_items

  def initialize(mapped_purchase:, mapped_purchase_items:)
    @mapped_purchase = mapped_purchase
    @mapped_purchase_items = mapped_purchase_items
  end
end
