require 'rails_helper'

RSpec.describe PurchaseItemsController, type: :controller do
  let(:admin) { Admin.new(email: 'test@gmail.com', password: 'password') }
  let(:purchase) { Purchase.new(id:) }
  let(:id) { '1' }
  let(:purchase_item) { Purchase::Item.new(id:, purchase_id: id) }
  let(:params) { { id: id } }

  before do
    admin_sign_id(admin)
    allow(Purchase).to receive(:find)
      .with(id)
      .and_return(purchase)
    allow(Purchase::Item).to receive(:find)
      .with(id)
      .and_return(purchase_item)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get(:index, params: params)
      expect(response).to render_template :index
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get(:edit, params: params)
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let(:params) do
      {
        id:,
        purchase_item: {
          purchase_id: id,
          name: 'purchase',
          price: '23',
          used: 'false',
          expiration_date: Date.today.to_s
        }
      }
    end
    let(:updated?) { true }
    let(:permitted_params) { build_permitted_parameters(params[:purchase_item], :permitted_params) }

    before do
      allow(purchase_item).to receive(:update)
        .with(permitted_params)
        .and_return(updated?)
    end

    it 'updates purchase item' do
      patch(:update, params: params)
      expect(response).to redirect_to items_purchase_path(id:)
      expect(flash[:notice]).to eq('Purchase item was successfully updated')
    end

    context "when update fails" do
      let(:updated?) { false }

      it 'updates purchase item' do
        patch(:update, params: params)
        expect(response).to redirect_to edit_purchase_item_path(id:)
        expect(flash[:alert]).to eq('Fail to update Purchase item')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:params) do
      {
        id:
      }
    end
    let(:destroyed?) { true }

    before do
      allow(purchase_item).to receive(:destroy!)
        .and_return(destroyed?)
    end

    it 'destroys purchase item' do
      delete(:destroy, params: params)
      expect(response).to redirect_to items_purchase_path(id:)
      expect(flash[:notice]).to eq('Purchase item was destroyed successfully')
    end

    context 'when destroy purchase item fails' do
      let(:destroyed?) { false }

      it 'does not destroys purchase item' do
        delete(:destroy, params: params)
        expect(response).to redirect_to items_purchase_path(id:)
        expect(flash[:alert]).to eq('Purchase item was not destroyed successfully')
      end
    end
  end
end
