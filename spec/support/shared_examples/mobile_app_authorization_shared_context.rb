RSpec.shared_context 'mobile_app_authorization' do
  let(:user) { User.new }
  let(:jwt_token_encoded) { 'jwt_token' }
  let(:jwt_token_decoded) do
    [
      ActiveSupport::HashWithIndifferentAccess.new(
        email: "email"
      )
    ]
  end

  before do
    request.headers['Authorization'] = "Bearer jwt_token"
    allow(ENV).to receive(:fetch)
      .with('SECRET_KEY_BASE', nil)
      .and_return('secret')
    allow(JWT).to receive(:decode)
      .with(
        jwt_token_encoded,
        'secret',
        true,
        algorithm: 'HS256'
      )
      .and_return(jwt_token_decoded)
    allow(User).to receive(:find_by)
      .with(email: 'email')
      .and_return(user)
  end
end
