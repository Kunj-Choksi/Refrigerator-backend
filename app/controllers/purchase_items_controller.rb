class PurchaseItemsController < ApplicationController
  before_action :set_purchase, only: [:index]
  before_action :set_purchase_item, except: [:index]

  def index
    @purchase_items = @purchase.purchase_items
  end

  def edit; end

  def update
    if @purchase_item.update(purchase_item_params)
      redirect_to items_purchase_path(@purchase_item.purchase_id), notice: 'Purchase item was successfully updated'
    else
      redirect_to edit_purchase_item_path(@purchase_item.id), alert: 'Fail to update Purchase item'
    end
  end

  def destroy
    if @purchase_item.destroy!
      redirect_to items_purchase_path(@purchase_item.purchase_id), notice: 'Purchase item was destroyed successfully'
    else
      redirect_to items_purchase_path(@purchase_item.purchase_id), alert: 'Purchase item was not destroyed successfully'
    end
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def set_purchase_item
    @purchase_item = Purchase::Item.find(params[:id])
  end

  def permitted_params
    %i[
      name price expiration_date quantity unit
    ]
  end

  def purchase_item_params
    params.require(:purchase_item).permit(permitted_params)
  end
end
