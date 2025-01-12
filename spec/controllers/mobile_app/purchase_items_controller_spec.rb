require 'rails_helper'

RSpec.xdescribe MobileApp::PurchaseItemsController do
  let(:user) { User.new }
  let(:purchase_item_id) { '1' }
  let(:params) { { id: purchase_item_id } }
  let(:purchase_item) do
    Purchase::Item.new(
      id: 1,
      name: 'Some Item',
      purchase_id: 2
    )
  end

  before do
    allow(controller).to receive(:params).and_return(params)
    allow(Purchase::Item).to receive(:find)
      .with(params[:id])
      .and_return(purchase_item)
    allow(User).to receive(:find_by_email)
      .with('email')
      .and_return(user)
  end

  describe 'GET #all_items' do
    let(:all_items) { Purchase::Item.all }

    before do
      allow(all_items).to receive(:order)
        .with(created_at: :desc)
    end

    it 'returns all items' do
      expect(Purchase::Item).to receive_message_chain(:all, :where)
        .with(used: false)
      expect(controller).to receive(:render)
        .with(json: { status: 'success', contents: nil })

      get :all_items, xhr: true
    end
  end

  describe 'GET #details' do
    it 'returns item details' do
      expect(controller).to receive(:render)
        .with(json: { status: 'success', contents: purchase_item })

      get :details, params:, xhr: true
    end
  end

  describe 'PATCH #update' do
    let(:params) do
      {
        id: '1',
        name: 'test',
        purchase_id: '3',
        price: '34'
      }
    end
    let(:updated?) { true }

    before do
      allow(PurchaseServices::ItemServices::SaveItem).to receive(:call)
        .with(purchase_item:, params:)
        .and_return(updated?)
    end

    it 'renders success message' do
      expect(controller).to receive(:render)
        .with(json: { status: 'success', message: 'Updated purchase item' })

      patch :update, params:
    end

    context 'when update fails' do
      let(:updated?) { false }

      it 'renders error message' do
        expect(controller).to receive(:render)
          .with(json: { status: 'error', message: 'Not updated purchase item' })

        patch :update, params:
      end
    end

    context 'when missing params' do
      let(:params) do
        {
          id: '1',
          name: 'test',
          purchase_id: '3'
        }
      end

      it 'renders error message' do
        expect(controller).to receive(:render)
          .with(json: { status: 'error', message: 'Missing required parameter price' })

        patch :update, params:
      end
    end
  end

  describe 'PATCH #mark_as_used' do
    let(:params) do
      {
        id: '1'
      }
    end
    let(:used_params) do
      {
        used: true
      }
    end
    let(:updated?) { true }

    before do
      allow(PurchaseServices::ItemServices::SaveItem).to receive(:call)
        .with(purchase_item:, params: used_params)
        .and_return(updated?)
    end

    it 'renders success message' do
      expect(controller).to receive(:render)
        .with(json: { status: 'success', message: 'Marked purchase item as used' })

      patch :mark_as_used, params:
    end

    context 'when update fails' do
      let(:updated?) { false }

      it 'renders error message' do
        expect(controller).to receive(:render)
          .with(json: { status: 'error', message: 'Not marked purchase item as used' })

        patch :mark_as_used, params:
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:params) do
      {
        id: '1'
      }
    end

    before do
      allow(purchase_item).to receive(:destroy!)
        .and_return(true)
    end

    it 'renders success message' do
      expect(controller).to receive(:render)
        .with(json: { status: 'success', message: 'Deleted purchase Item' })

      delete :destroy, params:
    end
  end
end
