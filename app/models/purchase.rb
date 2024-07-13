class Purchase < ApplicationRecord
  acts_as_paranoid

  has_one_attached :purchase_receipt, service: :google
  has_many :purchase_items, dependent: :destroy, class_name: 'Purchase::Item'
end
