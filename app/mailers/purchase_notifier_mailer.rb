class PurchaseNotifierMailer < ApplicationMailer
  default :from => ENV['SENDER_ADDRESS']

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_test_email()
    # @user = user
    mail( :to => 'gen.2polym.hn@gmail.com',
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
