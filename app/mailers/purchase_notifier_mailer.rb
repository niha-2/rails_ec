class PurchaseNotifierMailer < ApplicationMailer

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_purchase_details_email(billing_info, cart_products, products)
    @billing_info = billing_info
    @cart_products = cart_products
    @products = products

    mail( :to => @billing_info.email, :subject => '【購入明細】ご購入いただきありがとうございます！', :from => ENV['SENDER_ADDRESS'] )
  end
end
