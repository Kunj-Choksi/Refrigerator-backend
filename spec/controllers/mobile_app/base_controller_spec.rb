require 'rails_helper'

RSpec.describe MobileApp::BaseController, type: :controller do
  describe '#session_user' do
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

    it 'sets the user' do
      controller.send :session_user
      expect(assigns(:user)).to eq(user)
    end

    context 'when request headers is empty' do
      let(:jwt_token_encoded) { nil }
      let(:user) { nil }

      before do
        request.headers['Authorization'] = ""
      end

      it 'returns a error status with NOT_AUTHORIZED message' do
        expect(controller).to receive(:render)
          .with(json: { status: 'error', message: 'NOT_AUTHORIZED' })

        controller.send :session_user
      end
    end
  end

  describe '#render_result_json' do
    let(:object) { { id: 1, name: 'Test' } }

    it 'returns a success status when object is not nil' do
      expect(controller).to receive(:render)
        .with(json: { status: 'success', contents: object })

      controller.send(:render_result_json, object)
    end
  end

  describe '#render_result_message' do
    let(:message) { 'Success Is Failure' }

    it 'returns a success status when object is not nil' do
      expect(controller).to receive(:render)
        .with(json: { status: 'success', message: })

      controller.send(:render_result_message, message)
    end
  end

  describe '#render_error_message' do
    let(:message) { 'Failure Is Success' }

    it 'returns a success status when object is not nil' do
      expect(controller).to receive(:render)
        .with(json: { status: 'error', message: })

      controller.send(:render_error_message, message)
    end
  end

  describe '#has_sufficient_params?' do
    let(:params) do
      {
        foo: 'bar',
        bar: 'baz'
      }
    end
    let(:mandatory_params) { %i[foo bar baz] }

    before do
      allow(controller).to receive(:params)
        .and_return(params)
    end

    it 'render error message for missing params' do
      expect(controller).to receive(:render)
        .with(json: { status: 'error', message: 'Missing required parameter baz' })

      controller.send(:has_sufficient_params?, mandatory_params)
    end
  end
end
