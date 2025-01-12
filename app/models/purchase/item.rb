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
class Purchase::Item < ApplicationRecord
  acts_as_paranoid

  belongs_to :purchase
  scope :not_used, -> { where(used: false) }

  def name=(value)
    super(value.titleize)
  end
end
