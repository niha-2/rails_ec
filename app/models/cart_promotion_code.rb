# frozen_string_literal: true

class CartPromotionCode < ApplicationRecord
  belongs_to :cart
  validates :promotion_code, presence: true
end
