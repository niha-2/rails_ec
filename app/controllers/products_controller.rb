# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_cart_id

  def index
    @products = Product.all
    @cart_products = CartProduct.where(cart_id: @current_cart_id)
    @cart_product_quantity_sum = @cart_products.sum(:quantity)
  end

  def show
    @product = Product.find_by(id: params[:id])
    @related_products = Product.where.not(id: @product.id).order(created_at: :desc).limit(4)
  end

  private

  def set_cart_id
    if session[:cart_id]
      @current_cart_id = session[:cart_id]
    else
      @current_cart_id = Cart.create.id
      session[:cart_id] = @current_cart_id
    end
  end
end
