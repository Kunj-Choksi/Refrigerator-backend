class Purchase::Item < ApplicationRecord
  acts_as_paranoid

  belongs_to :purchase
end
