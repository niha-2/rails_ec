# frozen_string_literal: true

class CreateBillingInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :billing_infos do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :user_name, null: false
      t.string :email
      t.string :address, null: false
      t.string :address2
      t.string :country, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.boolean :same_address_flag
      t.boolean :save_info_flag
      t.string :payment_method, null: false
      t.string :name_on_card, null: false
      t.string :credit_card_number, null: false
      t.string :credit_card_expiration, null: false
      t.string :credit_card_cvv, null: false

      t.timestamps
    end
  end
end
