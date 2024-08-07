class Purchase::Item < ApplicationRecord
  acts_as_paranoid

  belongs_to :purchase
  scope :not_used, -> { where(used: false) }
  scope :with_expirations, -> { where.not(has_no_expiry: true, expiration_date: nil) }
end
