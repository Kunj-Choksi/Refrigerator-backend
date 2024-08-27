# == Schema Information
#
# Table name: purchase_items
#
#  id              :bigint           not null, primary key
#  purchase_id     :bigint
#  name            :string
#  price           :float
#  expiration_date :date
#  quantity        :float
#  unit            :string
#  item_type       :string
#  verifi_id       :string
#  verifi_metadata :json
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deleted_at      :date
#  used            :boolean          default(FALSE)
#  has_no_expiry   :boolean          default(FALSE)
#
require "test_helper"

class Purchase::ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
