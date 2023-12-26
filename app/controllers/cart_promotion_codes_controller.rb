# frozen_string_literal: true

class CartPromotionCodesController < ApplicationController
  before_action :set_cart

  def create
    Rails.logger.debug params
    @cart_promotion_code = CartPromotionCode.new(cart_promotion_code_params)
    @promotion_code = PromotionCode.find_by(code: @cart_promotion_code.promotion_code)

    if @promotion_code
      @cart_promotion_code.save!
      redirect_to cart_products_path, notice: 'プロモーションコードを適用しました'
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Transaction failed! Error messages: #{e.record.errors.full_messages.join(', ')}")
    redirect_to cart_products_path, notice: 'プロモーションコードの適用に失敗しました', status: :unprocessable_entity
  end

  private

  def cart_promotion_code_params
    params.require(:cart_promotion_code).permit(:promotion_code).merge(cart_id: @current_cart.id)
  end
end
