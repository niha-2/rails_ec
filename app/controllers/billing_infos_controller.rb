# frozen_string_literal: true

class BillingInfosController < ApplicationController
  before_action :set_cart
  before_action :set_current_cart_products, only: %i[create]

  def create
    @billing_info = BillingInfo.new(billing_info_params)
    @products = Product.all

    # プロモーションコードの割引額を計算
    @cart_promotion_code = CartPromotionCode.find_by(cart_id: @current_cart.id)
    if @cart_promotion_code
      @promotion_code = PromotionCode.find_by(code: @cart_promotion_code.promotion_code)
      @billing_info.discount_amount = @promotion_code.discount_amount
    end

    ActiveRecord::Base.transaction do
      @billing_info.save!
      @cart_products.each do |cart_product|
        @purchase_detail = PurchaseDetail.new(billing_info_id: @billing_info.id, product_id: cart_product.product_id,
                                              quantity: cart_product.quantity)
        @purchase_detail.save!
      end
      if @cart_promotion_code
        @promotion_code.destroy!
        @cart_promotion_codes = CartPromotionCode.where(cart_id: @current_cart.id)
        @cart_promotion_codes.destroy_all
      end
      Cart.find(@current_cart.id).destroy!
    end
    # カートの中身を空にする
    session[:cart_id] = nil
    # 購入明細メール送信
    if @billing_info.email.present?
      PurchaseNotifierMailer.send_purchase_details_email(@billing_info, @cart_products, @products).deliver
    end
    redirect_to root_path, notice: '購入ありがとうございます'
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Transaction failed! Error messages: #{e.record.errors.full_messages.join(', ')}")
    render 'cart_products/index', notice: '購入に失敗しました', status: :unprocessable_entity
  end

  private

  def billing_info_params
    params.require(:billing_info).permit(:first_name, :last_name, :user_name, :email, :address, :address2, :country,
                                         :state, :zip, :same_address_flag, :save_info_flag, :payment_method,
                                         :name_on_card, :credit_card_number, :credit_card_expiration, :credit_card_cvv)
  end

  def set_current_cart_products
    @cart_products = @current_cart.cart_products
  end
end
