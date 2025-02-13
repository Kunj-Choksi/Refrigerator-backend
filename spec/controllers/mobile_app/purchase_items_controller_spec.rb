require 'rails_helper'

RSpec.describe MobileApp::PurchaseItemsController do
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
    allow(Purchase::Item).to receive(:find)
      .with(params[:id])
      .and_return(purchase_item)
  end

  describe 'GET #all_items' do
    let(:purchase_items) { Purchase::Item.all }
    let(:call_api_request) { get :all_items, xhr: true }
    let(:response) do
      { json: { status: 'success', contents: purchase_items } }
    end

    before do
      allow(Purchase::Item).to receive(:all)
        .and_return(purchase_items)
      allow(purchase_items).to receive(:order)
        .with(created_at: :desc)
        .and_return(purchase_items)
    end

    it_behaves_like 'mobile app api request'
  end

  describe 'GET #details' do
    let(:call_api_request) { get :details, params: params, xhr: true }
    let(:response) do
      {
        json: { status: 'success', contents: purchase_item }
      }
    end

    it_behaves_like 'mobile app api request'
  end

  describe 'PATCH #update' do
    let(:call_api_request) { patch :update, params: params, xhr: true }
    let(:response) do
      {
        json: { status: 'success', message: 'Updated purchase item' }
      }
    end
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

    it_behaves_like 'mobile app api request'

    context 'when update fails' do
      let(:updated?) { false }
      let(:response) do
        {
          json: { status: 'error', message: 'Not updated purchase item' }
        }
      end

      it_behaves_like 'mobile app api request'
    end

    context 'when missing params' do
      let(:params) do
        {
          id: '1',
          name: 'test',
          purchase_id: '3'
        }
      end
      let(:response) do
        {
          json: { status: 'error', message: 'Missing required parameter price' }
        }
      end

      it_behaves_like 'mobile app api request'
    end
  end

  describe 'PATCH #mark_as_used' do
    let(:call_api_request) { patch :mark_as_used, params: params }
    let(:response) do
      { json: { status: 'success', message: 'Marked purchase item as used' } }
    end
    let(:params) { { id: '1' } }
    let(:used_params) { { used: true } }
    let(:updated?) { true }

    before do
      allow(PurchaseServices::ItemServices::SaveItem).to receive(:call)
        .with(purchase_item:, params: used_params)
        .and_return(updated?)
    end

    it_behaves_like 'mobile app api request'

    context 'when update fails' do
      let(:response) do
        { json: { status: 'error', message: 'Not marked purchase item as used' } }
      end
      let(:updated?) { false }

      it_behaves_like 'mobile app api request'
    end
  end

  describe 'DELETE #destroy' do
    let(:call_api_request) { delete :destroy, params: params }
    let(:response) do
      { json: { status: 'success', message: 'Deleted purchase Item' } }
    end
    let(:params) { { id: '1' } }

    before do
      allow(purchase_item).to receive(:destroy!)
        .and_return(true)
    end

    it_behaves_like 'mobile app api request'
  end
end
