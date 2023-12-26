# frozen_string_literal: true

class AddDiscountAmountToBillingInfos < ActiveRecord::Migration[7.0]
  def change
    add_column :billing_infos, :discount_amount, :integer
  end
end
