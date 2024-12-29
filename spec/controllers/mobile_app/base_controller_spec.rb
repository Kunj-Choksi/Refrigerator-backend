require 'rails_helper'

RSpec.describe MobileApp::BaseController, type: :controller do
  xdescribe '#set_user' do
    let(:user) { User.new }

    before do
      allow(User).to receive(:first)
        .and_return(user)
    end

    it 'sets the user' do
      controller.send :set_user
      expect(assigns(:user)).to eq(user)
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
