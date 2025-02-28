require 'rails_helper'

RSpec.describe UserServices::SaveDeviceInfo do
  subject { described_class.call(user:, params:) }

  let(:user) { User.new }
  let(:params) do
    {
      fcm_token: 'fcm_token',
      device_type: 'device_type'
    }
  end
  let(:device) { nil }

  before do
    allow(user).to receive(:device)
      .and_return(device)
  end

  context 'for new device' do
    it { is_expected.to be(true) }
  end
end
