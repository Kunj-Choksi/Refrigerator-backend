require "rails_helper"

RSpec.describe PurchasesController, type: :controller do
  let(:admin) { Admin.new(email: "test@gmail.com", password: "password") }
  let(:purchase) { Purchase.new(id:) }
  let(:id) { "12" }

  before do
    admin_sign_id(admin)
    allow(Purchase).to receive(:find)
      .with(id)
      .and_return(purchase)
  end

  describe "GET #index" do
    let(:purchases) { [purchase] }

    before do
      allow(Purchase).to receive_message_chain(:all, :order)
        .with(created_at: :desc)
        .and_return(purchases)
    end

    it "renders the index" do
      get :index
      expect(response).to render_template :index
    end

    it "assigns the purchases" do
      get :index
      expect(assigns(:purchases)).to eq([purchase])
    end
  end

  describe "GET #show" do
    let(:params) do
      {
        id:
      }
    end

    it "renders show page" do
      get(:show, params:)
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before do
      allow(Purchase).to receive(:new)
        .and_return(purchase)
    end

    it "renders new page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let(:params) do
      {
        purchase: {
          store_name: "Walmart",
          billing_amount: "23.45",
          partial_amount: "10.2",
          purchase_type: "type",
          purchase_date: "2024-11-01",
          purchase_receipt: "purchase_receipt"
        }
      }
    end
    let(:permitted_params) { build_permitted_parameters(params[:purchase], :permitted_params) }
    let(:saved?) { true }

    before do
      allow(Purchase).to receive(:new).and_return(purchase)
      allow(PurchaseServices::SavePurchase).to receive(:call)
        .with(purchase:, params: permitted_params)
        .and_return(saved?)
    end

    it "post new purchase" do
      post(:create, params:)
      expect(response).to redirect_to purchase_url(purchase)
      expect(flash[:notice]).to eq("Purchase was successfully created.")
    end

    context "when purchase creation fails" do
      let(:saved?) { false }

      it "renders the purchase page" do
        post(:create, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    let(:params) do
      {
        id: id,
        purchase: {
          store_name: "Walmart",
          billing_amount: "23.45",
          partial_amount: "10.2",
          purchase_type: "type",
          purchase_date: "2024-11-01",
          purchase_receipt: "purchase_receipt"
        }
      }
    end
    let(:permitted_params) { build_permitted_parameters(params[:purchase], :permitted_params) }
    let(:updated?) { true }

    before do
      allow(purchase).to receive(:update)
        .and_return(updated?)
    end

    it "updates the purchase" do
      patch(:update, params: params)
      expect(response).to redirect_to purchase_url(purchase)
      expect(flash[:notice]).to eq("Purchase was successfully updated.")
    end

    context "when update purchase fails" do
      let(:updated?) { false }

      it "renders purchase page" do
        patch(:update, params: params)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:params) { { id: id } }

    before do
      allow(purchase).to receive(:destroy!)
        .and_return(true)
    end

    it "destroys the purchase" do
      delete :destroy, params: params
      expect(response).to redirect_to purchases_url
      expect(flash[:notice]).to eq('Purchase was successfully destroyed.')
    end
  end
end
