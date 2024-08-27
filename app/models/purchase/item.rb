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
class Purchase::Item < ApplicationRecord
  acts_as_paranoid

  belongs_to :purchase
  scope :not_used, -> { where(used: false) }
  scope :with_expirations, -> { where.not(has_no_expiry: true, expiration_date: nil) }
end
