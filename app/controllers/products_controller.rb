class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
    @related_products = Product.where.not(id: @product.id).order(created_at: :desc).limit(4)
  end

  def new
  end

  def edit
  end
end
