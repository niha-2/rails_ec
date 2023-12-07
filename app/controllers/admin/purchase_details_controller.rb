# frozen_string_literal: true

module Admin
  class PurchaseDetailsController < ApplicationController
    def index
      @billing_infos = BillingInfo.all
    end

    def show
      @billing_info = BillingInfo.find(params[:id])
      @purchase_details = @billing_info.purchase_details
    end
  end
end
