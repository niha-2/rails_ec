# frozen_string_literal: true

module Admin
  class PurchaseDetailsController < ApplicationController
    def index
      @billing_infos = BillingInfo.all
    end

    def show
      @billing_info = BillingInfo.find(params[:id])
      @purchase_details = @billing_info.purchase_details
      @discount_amount = (@billing_info.discount_amount.presence || 0)
      @purchase_sum = [@purchase_details.sum { |purchase_detail|
                         purchase_detail.product.price * purchase_detail.quantity
                       } - @discount_amount, 0].max
    end
  end
end
