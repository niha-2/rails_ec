# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy

  def add_or_initialaize_product(product_id, quantity)
    @cart_product = CartProduct.find_or_initialize_by(product_id:, cart_id: id)
    @cart_product.quantity = (@cart_product.quantity || 0) + quantity
    @cart_product
  end
end
