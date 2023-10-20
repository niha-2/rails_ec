# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :set_cart

  def index
    @cart_products = @current_cart.cart_products
    @products = Product.all
  end

  def add
    @product_id = params[:id]
    @cart_product = CartProduct.find_by(product_id: @product_id, cart_id: @current_cart.id)

    @quantity = params[:product_quantity] ? params[:product_quantity].to_i : 1
    if @cart_product
      @cart_product.quantity += @quantity
    else
      @cart_product = CartProduct.new(product_id: @product_id, cart_id: @current_cart.id,
                                      quantity: @quantity)
    end

    if @cart_product.save
      if params[:product_quantity]
        redirect_to product_path(@product_id), notice: 'カートに商品を追加しました'
      else
        redirect_to products_path, notice: 'カートに商品を追加しました'
      end
    elsif params[:product_quantity]
      redirect_to product_path(@product_id), notice: 'カートに商品を追加できませんでした'
    else
      redirect_to products_path, notice: 'カートに商品を追加できませんでした'
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
