# frozen_string_literal: true

class CreateCartPromotionCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_promotion_codes do |t|
      t.references :cart, null: false, foreign_key: true
      t.string :promotion_code

      t.timestamps
    end
    add_index :cart_promotion_codes, :promotion_code, unique: true
  end
end
