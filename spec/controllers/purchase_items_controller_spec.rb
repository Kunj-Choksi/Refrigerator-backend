require 'rails_helper'

RSpec.describe PurchaseItemsController do
  let(:admin) { create(:admin) }
  let(:purchase) { Purchase.new(id: purchase_id) }
  let(:purchase_id) { '1' }

  before do
    sign_in admin
    allow(Purchase).to receive(:find)
      .with(purchase_id)
      .and_return(purchase)
  end

  describe 'GET #index' do
    let(:params) do
      {
        id: purchase_id
      }
    end

    it 'returns http success' do
      get(:index, params:)
      expect(response).to render_template :index
    end
  end
end
