require "rails_helper"

RSpec.describe MobileApp::UserController do
  let(:params) { double("params") }
  let(:user) { double("user") }

  describe "POST #save_device_info" do
    let(:params) do
      {
        fcm_token: "fcm_token",
        device_type: "device_type"
      }
    end
    let(:saved?) { true }
    let(:call_api_request) do
      post :save_device_info, params: params, xhr: true
    end
    let(:response) do
      { json: { status: "success", message: "Saved device information" } }
    end

    before do
      allow(UserServices::SaveDeviceInfo).to receive(:call).
        with(user: user, params: params).
        and_return(saved?)
    end

    it_behaves_like "mobile app api request"

    context "when it fails while saving device info" do
      let(:saved?) { false }
      let(:response) do
        { json: { status: "error", message: "Error while saving device information" } }
      end

      it_behaves_like "mobile app api request"
    end
  end
end
