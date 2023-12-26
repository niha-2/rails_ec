# frozen_string_literal: true

class BillingInfosController < ApplicationController
  before_action :set_cart
  before_action :set_current_cart_products, only: %i[create]

  def create
    @billing_info = BillingInfo.new(billing_info_params)
    @products = Product.all
    # プロモーションコードの割引額を計算
    set_discount_amount

    ActiveRecord::Base.transaction do
      @billing_info.save!
      save_purchase_details
      if @cart_promotion_code
        @promotion_code.destroy!
        @cart_promotion_codes = CartPromotionCode.where(cart_id: @current_cart.id)
        @cart_promotion_codes.destroy_all
      end
      Cart.find(@current_cart.id).destroy!
    end
    # カートの中身を空にする
    create_cart_session
    # 購入明細メール送信
    send_purchase_details_email if @billing_info.email.present?

    redirect_to root_path, notice: '購入ありがとうございます'
  rescue ActiveRecord::RecordInvalid => e
    handle_transaction_error(e)
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

  def set_discount_amount
    @cart_promotion_code = CartPromotionCode.find_by(cart_id: @current_cart.id)
    return unless @cart_promotion_code

    @promotion_code = PromotionCode.find_by(code: @cart_promotion_code.promotion_code)
    @billing_info.discount_amount = @promotion_code.discount_amount
  end

  def save_purchase_details
    @cart_products.each do |cart_product|
      @purchase_detail = PurchaseDetail.new(billing_info_id: @billing_info.id, product_id: cart_product.product_id,
                                            quantity: cart_product.quantity)
      @purchase_detail.save!
    end
  end

  def clear_cart_session
    session[:cart_id] = nil
  end

  def send_purchase_details_email
    PurchaseNotifierMailer.send_purchase_details_email(@billing_info, @cart_products, @products).deliver
  end

  def handle_transaction_error(error)
    Rails.logger.error("Transaction failed! Error messages: #{error.record.errors.full_messages.join(', ')}")
    render 'cart_products/index', notice: '購入に失敗しました', status: :unprocessable_entity
  end
end
