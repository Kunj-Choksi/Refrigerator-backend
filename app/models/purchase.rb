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
class Purchase < ApplicationRecord
  acts_as_paranoid

  has_one_attached :purchase_receipt, service: :azure
  has_many :purchase_items, dependent: :destroy, class_name: 'Purchase::Item'
  def store_name=(value)
    super(value.titleize)
  end
end
