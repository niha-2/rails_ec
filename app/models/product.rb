# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end
