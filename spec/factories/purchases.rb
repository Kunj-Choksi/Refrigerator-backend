# == Schema Information
#
# Table name: purchases
#
#  id              :bigint           not null, primary key
#  billing_amount  :float
#  deleted_at      :date
#  partial_amount  :float
#  purchase_date   :date
#  purchase_type   :string
#  store_logo      :string           default("https://storage.cloud.google.com/refrigerator_receipts/supermarket-logo.jpeg")
#  store_name      :string
#  verifi_metadata :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  verifi_id       :string
#
FactoryBot.define do
  factory :purchases do
  end
end
