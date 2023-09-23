class Admin::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path(), notice: "商品「#{@product.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def index
  end

  def destroy
    @product.destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :image)
  end

end
