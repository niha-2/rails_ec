# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image
  has_many :cart_products, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  # validates :image, presence: true
end
