# frozen_string_literal: true

class CreatePurchaseDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_details do |t|
      t.references :billing_info, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
