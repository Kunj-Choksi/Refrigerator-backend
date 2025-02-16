class MobileApp::PurchasesController < MobileApp::BaseController
  before_action :session_user
  before_action :set_purchase, except: %i[list create]

  def list
    purchases = Purchase.order(purchase_date: :desc).select(:id, :store_name, :billing_amount, :purchase_date, :store_logo)
    render_result_json purchases
  end

  def purchase
    render_result_json @purchase
  end

  def purchase_items
    return unless has_sufficient_params?([:id])

    render_result_json @purchase.purchase_items.order(used: :asc, created_at: :desc)
  end

  def create
    return unless has_sufficient_params?(%i[purchase_receipt])

    if PurchaseServices::SavePurchase.call(purchase: Purchase.new, params: params)
      render_result_message "Created purchase"
    else
      render_error_message "Error while creating purchase"
    end
  end

  def update
    return unless has_sufficient_params?(%i[id store_name billing_amount purchase_date])

    if PurchaseServices::SavePurchase.call(purchase: @purchase, params: params)
      render_result_message "Updated purchase"
    else
      render_error_message "Error while updating purchase"
    end
  end

  def destroy
    return unless has_sufficient_params?(%i[id])

    if @purchase.destroy!
      render_result_message "Deleted purchase"
    else
      render_error_message "Error while deleting purchase"
    end
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end
end
