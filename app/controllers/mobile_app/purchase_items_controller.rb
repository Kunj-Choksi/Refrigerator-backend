class MobileApp::PurchaseItemsController < MobileApp::BaseController
  before_action :set_purchase_item, except: [:all_items]

  def all_items
    render_result_json Purchase::Item.all.order(used: :asc, created_at: :desc)
  end

  def details
    render_result_json @purchase_item
  end

  def update
    return unless has_sufficient_params?(%i[id name purchase_id price quantity unit])

    if PurchaseServices::ItemServices::SaveItem.call(purchase_item: @purchase_item, params:)
      render_result_message 'Updated purchase item'
    else
      render_error_message 'Not updated purchase item'
    end
  end

  def mark_as_used
    if PurchaseServices::ItemServices::SaveItem.call(purchase_item: @purchase_item, params: { used: true })
      render_result_message 'Marked purchase item as used'
    else
      render_error_message 'Not marked purchase item as used'
    end
  end

  def destroy
    if @purchase_item.destroy!
      render_result_message 'Deleted purchase Item'
    else
      render_error_message 'Not deleted purchase Item'
    end
  end

  private

  def set_purchase_item
    @purchase_item = Purchase::Item.find(params[:id])
  end
end
