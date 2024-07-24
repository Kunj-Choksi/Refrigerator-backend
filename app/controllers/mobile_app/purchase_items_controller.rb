class MobileApp::PurchaseItemsController < MobileApp::BaseController
  before_action :set_purchase_item

  def details
    render_result_json @purchase_item
  end

  def update
    return unless has_sufficient_params?(%w[id name purchase_id price expiration_date quantity unit])

    @purchase_item.assign_attributes(
      name: params[:name],
      price: params[:price],
      quantity: params[:quantity],
      unit: params[:unit],
      expiration_date: params[:expiration_date]
    )

    if @purchase_item.save!
      render_result_message 'Updated purchase item'
    else
      render_error_message 'Not updated purchase item'
    end
  end

  private

  def set_purchase_item
    @purchase_item = Purchase::Item.find(params[:id])
  end
end
