class PurchaseDetail < ApplicationRecord
  belongs_to :billing_info
  belongs_to :product
  validates :quantity, presence: true
end
