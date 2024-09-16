# == Schema Information
#
# Table name: user_devices
#
#  id          :bigint           not null, primary key
#  device_type :string
#  fcm_token   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_user_devices_on_user_id  (user_id)
#
class User::Device < ApplicationRecord
  belongs_to :user
end
