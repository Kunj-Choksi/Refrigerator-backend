# == Schema Information
#
# Table name: user_devices
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  fcm_token   :string
#  device_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class User::DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
