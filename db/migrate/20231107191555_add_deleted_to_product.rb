# frozen_string_literal: true

class AddDeletedToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :deleted, :boolean
  end
end
