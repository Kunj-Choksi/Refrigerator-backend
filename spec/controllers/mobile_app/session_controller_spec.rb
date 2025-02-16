require "rails_helper"

RSpec.describe MobileApp::SessionController do
  let(:params) { double("params") }

  before do
    allow(controller).to receive(:params)
      .and_return(params)
  end

  describe "POST #login" do
    let(:params) do
      {
        email: email,
        password: password
      }
    end
    let(:email) { "some@example.com" }
    let(:password) { "password" }
    let(:user) { User.new(email: email, password: password) }
    let(:call_api_request) do
      post :login, params: params, xhr: true
    end

    before do
      allow(User).to receive(:find_by).
        with(email: email).
        and_return(user)
    end

    context "when user exists with email" do
      let(:authenticated?) { true }

      before do
        allow(user).to receive(:authenticate).
          with(password).
          and_return(authenticated?)
      end

      context "when it authenticate user" do
        let(:payload) do
          {
            email: email,
            password: password
          }
        end
        let(:token) { "token" }
        let(:secret) { "secret" }
        let(:response) do
          { json: { status: "success", contents: token } }
        end

        before do
          allow(ENV).to receive(:fetch).
            with("SECRET_KEY_BASE", nil).
            and_return(secret)
          allow(JWT).to receive(:encode).
            with(payload, secret).
            and_return(token)
        end

        it "render token response" do
          expect(controller).to receive(:render)
            .with(response)

          call_api_request
        end
      end

      context "when password is invalid" do
        let(:authenticated?) { false }
        let(:response) do
          { json: { status: "error", message: "Password is incorrect" } }
        end

        it "render error response" do
          expect(controller).to receive(:render)
            .with(response)

          call_api_request
        end
      end
    end

    context "when user not found" do
      let(:user) { nil }
      let(:response) do
        { json: { status: "error", message: "User not found" } }
      end

      it "render error response" do
        expect(controller).to receive(:render)
          .with(response)

        call_api_request
      end
    end
  end
end
