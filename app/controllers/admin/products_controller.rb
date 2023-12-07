# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :basic_auth
    before_action :set_product, only: %i[edit update destroy]

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params_create)

      if @product.save
        redirect_to admin_products_path, notice: "商品「#{@product.name}」を登録しました"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      @product_update = Product.new(product_params_create)

      ActiveRecord::Base.transaction do
        # アップロードされる画像がない場合は、元の画像をそのまま使う
        unless @product_update.image.attached?
          @product_update.image.attach(@product.image.blob) if @product.image.attached?
        end

        @product.update!(deleted: true)
        @product_update.save!
      end

      redirect_to admin_products_path, notice: "商品「#{@product.name}」を更新しました"
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Transaction failed! Error messages: #{e.record.errors.full_messages.join(', ')}")
      render :edit, status: :unprocessable_entity
    end

    def index
      @products = Product.where(deleted: false)
    end

    def destroy
      @product.update(deleted: true)
      redirect_to admin_products_path, notice: "商品「#{@product.name}」を削除しました", status: :see_other
    end

    private

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end

    def product_params_create
      params.require(:product).permit(:name, :price, :description, :image).merge(deleted: false)
    end

    def set_product
      @product = Product.find(params[:id])
    end

  end
end
