# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :set_cart

  def index
    @cart_products = @current_cart.cart_products
    @products = Product.all
  end

  def add
    @quantity = params[:product_quantity] ? params[:product_quantity].to_i : 1
    @cart_product = @current_cart.add_or_initialaize_product(params[:id], @quantity)

    @redirect_path = params[:product_quantity] ? product_path(@product_id) : products_path
    if @cart_product.save
      redirect_to @redirect_path, notice: 'カートに商品を追加しました'
    else
      redirect_to @redirect_path, notice: 'カートに商品を追加できませんでした'
    end
  end

  def destroy
    set_cart_product
    @delete_product = Product.find(@cart_product.product_id)
    @cart_product.destroy
    redirect_to cart_products_path, notice: "カートから商品「#{@delete_product.name}」を削除しました"
  end

  def update; end

  private

  def set_cart_product
    @cart_product = CartProduct.find(params[:id])
  end
end
