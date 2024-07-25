class MobileApp::PurchasesController < MobileApp::BaseController
  def list
    render_result_json Purchase.all.order(created_at: :desc)
  end

  def purchase_items
    return unless has_sufficient_params?([:id])

    purchase = Purchase.find(params[:id])

    render_result_json purchase.purchase_items.order(used: :asc, created_at: :desc)
  end

  def create
    return unless has_sufficient_params?(%w[store_name billing_amount purchase_date purchase_receipt])

    if PurchaseServices::SavePurchase.call(purchase: Purchase.new, params:)
      render_result_message 'Added purchase'
    else
      render_error_message 'Not Added purchase'
    end
  end
end
