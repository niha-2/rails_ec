class RenameCreditCartNumberColumnToBillingInfos < ActiveRecord::Migration[7.0]
  def change
    rename_column :billing_infos, :credit_cart_number, :credit_card_number
  end
end
