require "rails_helper"

RSpec.describe MobileApp::PurchasesController do
  let(:params) { double("params") }

  describe "GET #list" do
    let(:purchases) { double("purchases") }
    let(:call_api_request) { get :list, xhr: true }
    let(:response) do
      { json: { status: "success", contents: purchases } }
    end

    before do
      allow(Purchase).to receive(:order).
        with(purchase_date: :desc).
        and_return(purchases)
      allow(purchases).to receive(:select).
        with(:id, :store_name, :billing_amount, :purchase_date, :store_logo).
        and_return(purchases)
    end

    it_behaves_like "mobile app api request"
  end

  describe "GET #purchase" do
    let(:params) { { id: purchase_id } }
    let(:purchase_id) { 1 }
    let(:purchase) { double("purchase") }
    let(:call_api_request) { get :purchase, params: params, xhr: true }
    let(:response) do
      {
        json: { status: "success", contents: purchase }
      }
    end

    before do
      allow(Purchase).to receive(:find).
        with(purchase_id).
        and_return(purchase)
    end

    it_behaves_like "mobile app api request"
  end

  describe "POST #create" do
    let(:params) { { purchase_receipt: "purchase_receipt" } }
    let(:purchase) { Purchase.new }
    let(:saved?) { true }
    let(:call_api_request) { post :create, params: params, xhr: true }
    let(:response) do
      { json: { status: "success", message: "Created purchase" } }
    end

    before do
      allow(Purchase).to receive(:new).
        and_return(purchase)
      allow(PurchaseServices::SavePurchase).to receive(:call).
        with(purchase: purchase, params: params).
        and_return(saved?)
    end

    it_behaves_like "mobile app api request"

    context "when it fails" do
      let(:saved?) { false }
      let(:response) do
        { json: { status: "error", message: "Error while creating purchase" } }
      end

      it_behaves_like "mobile app api request"
    end
  end

  describe "PATCH #update" do
    let(:params) do
      {
        id: purchase_id,
        store_name: "Walmart",
        billing_amount: 100.21,
        purchase_date: Date.new(2024, 2, 9)
      }
    end
    let(:purchase_id) { 1 }
    let(:purchase) { double("purchase") }
    let(:updated?) { true }
    let(:call_api_request) { patch :update, params: params, xhr: true }
    let(:response) do
      { json: { status: "success", message: "Updated purchase" } }
    end

    before do
      allow(Purchase).to receive(:find).
        with(purchase_id).
        and_return(purchase)
      allow(PurchaseServices::SavePurchase).to receive(:call).
        with(purchase: purchase, params: params).
        and_return(updated?)
    end

    it_behaves_like "mobile app api request"

    context "when it fails" do
      let(:updated?) { false }
      let(:response) do
        { json: { status: "error", message: "Error while updating purchase" } }
      end

      it_behaves_like "mobile app api request"
    end
  end

  describe "DELETE #destroy" do
    let(:params) { { id: purchase_id } }
    let(:purchase_id) { 1 }
    let(:purchase) { double("purchase") }
    let(:destroyed?) { true }
    let(:call_api_request) { delete :destroy, params: params, xhr: true }
    let(:response) do
      { json: { status: "success", message: "Deleted purchase" } }
    end

    before do
      allow(Purchase).to receive(:find).
        with(purchase_id).
        and_return(purchase)
      allow(purchase).to receive(:destroy!).
        and_return(destroyed?)
    end

    it_behaves_like "mobile app api request"

    context "when it fails" do
      let(:destroyed?) { false }
      let(:response) do
        { json: { status: "error", message: "Error while deleting purchase" } }
      end

      it_behaves_like "mobile app api request"
    end
  end
end
