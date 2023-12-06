class Admin::PurchaseDetailsController < ApplicationController
  def index
    @billing_infos = BillingInfo.all
  end

  def show
    @billing_info = BillingInfo.find(params[:id])
    @purchase_details = @billing_info.purchase_details
    @products = Product.all
  end
end
