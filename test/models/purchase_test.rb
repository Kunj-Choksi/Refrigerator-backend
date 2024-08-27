# == Schema Information
#
# Table name: purchases
#
#  id              :bigint           not null, primary key
#  store_name      :string
#  billing_amount  :float
#  partial_amount  :float
#  purchase_type   :string
#  purchase_date   :date
#  store_logo      :string           default("https://storage.cloud.google.com/refrigerator_receipts/supermarket-logo.jpeg")
#  verifi_id       :string
#  verifi_metadata :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deleted_at      :date
#
require "test_helper"

class PurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
