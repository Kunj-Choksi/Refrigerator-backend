# == Schema Information
#
# Table name: purchase_items
#
#  id              :bigint           not null, primary key
#  deleted_at      :date
#  expiration_date :date
#  item_type       :string
#  name            :string
#  price           :float
#  quantity        :float
#  unit            :string
#  used            :boolean          default(FALSE)
#  verifi_metadata :json
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  purchase_id     :bigint
#  verifi_id       :string
#
# Indexes
#
#  index_purchase_items_on_purchase_id  (purchase_id)
#
# Foreign Keys
#
#  fk_rails_...  (purchase_id => purchases.id)
#
require "test_helper"

class Purchase::ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
