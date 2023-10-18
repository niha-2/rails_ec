# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :set_cart

  def index
    @cart_products = CartProduct.where(cart_id: @current_cart.id)
    @products = Product.all
  end

  def add_product_to_cart
    @product_id = params[:id]
    @cart_product = CartProduct.find_by(product_id: @product_id, cart_id: @current_cart.id)

    if @cart_product
      @cart_product.quantity += 1
    else
      @cart_product = CartProduct.new(product_id: @product_id, cart_id: @current_cart.id, quantity: 1)
    end

    if @cart_product.save
      redirect_to products_path, notice: 'カートに商品を追加しました'
    else
      redirect_to products_path, notice: 'カートに商品を追加できませんでした'
    end
  end

  def add_some_products_to_cart_product
    @product_quantity = params[:product_quantity]
    @product = Product.find(params[:id])
    @cart_product = CartProduct.find_by(product_id: @product.id, cart_id: @current_cart.id)

    if @cart_product
      @cart_product.quantity += @product_quantity.to_i
    else
      @cart_product = CartProduct.new(product_id: @product.id, cart_id: @current_cart.id,
                                      quantity: @product_quantity.to_i)
    end

    if @cart_product.save
      redirect_to product_path(@product.id), notice: 'カートに商品を追加しました'
    else
      redirect_to product_path(@product.id), notice: 'カートに商品を追加できませんでした'
    end
  end

  def destroy
    set_cart_product()
    # @cart_product = CartProduct.find(params[:id])
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
