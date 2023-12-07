# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :set_cart
  before_action :set_cart_product, only: %i[destroy]
  before_action :set_current_cart_products, only: %i[index]

  def index
    @products = Product.all
    @billing_info = BillingInfo.new
  end

  def add
    @product_id = params[:id]
    @quantity = params[:product_quantity] ? params[:product_quantity].to_i : 1
    @cart_product = @current_cart.add_or_initialaize_product(@product_id, @quantity)

    @redirect_path = params[:product_quantity] ? product_path(@product_id) : products_path
    if @cart_product.save
      redirect_to @redirect_path, notice: 'カートに商品を追加しました'
    else
      redirect_to @redirect_path, notice: 'カートに商品を追加できませんでした'
    end
  end

  def destroy
    @delete_product = Product.find(@cart_product.product_id)
    @cart_product.destroy
    redirect_to cart_products_path, notice: "カートから商品「#{@delete_product.name}」を削除しました"
  end

  def update; end

  private

  def set_cart_product
    @cart_product = CartProduct.find(params[:id])
  end

  def set_current_cart_products
    @cart_products = @current_cart.cart_products
  end
end
