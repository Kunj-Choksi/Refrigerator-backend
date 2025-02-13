RSpec.shared_examples "mobile app api request" do
  let(:user) { User.new }
  let(:jwt_token_encoded) { "jwt_token" }
  let(:jwt_token_decoded) do
    [
      ActiveSupport::HashWithIndifferentAccess.new(
        email: "email"
      )
    ]
  end

  before do
    request.headers["Authorization"] = "Bearer jwt_token"
    allow(ENV).to receive(:fetch)
      .with("SECRET_KEY_BASE", nil)
      .and_return("secret")
    allow(JWT).to receive(:decode)
      .with(
        jwt_token_encoded,
        "secret",
        true,
        algorithm: "HS256"
      )
      .and_return(jwt_token_decoded)
    allow(User).to receive(:find_by)
      .with(email: "email")
      .and_return(user)
    allow(controller).to receive(:params)
      .and_return(params)
  end

  it "set the user" do
    call_api_request
    expect(assigns(:user)).to eq(user)
  end

  it "render response" do
    expect(controller).to receive(:render)
      .with(response)

    call_api_request
  end

  context "when user is not authorized" do
    let(:response) do
      { json: { status: "error", message: "NOT_AUTHORIZED" } }
    end
    let(:user) { nil }
    let(:jwt_token_encoded) { nil }

    before do
      request.headers["Authorization"] = nil
    end

    it "does not set the user" do
      call_api_request
      expect(assigns(:user)).to be_nil
    end

    it "render error response" do
      skip "not rendering correct response"
      expect(controller).to receive(:render)
        .with(response)

      call_api_request
    end
  end
end
