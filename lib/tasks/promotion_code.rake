# frozen_string_literal: true

require 'securerandom'

namespace :promotion_code do
  desc 'Generate promotion codes'
  task generate: :environment do
    10.times do
      code = SecureRandom.alphanumeric(7)
      discount_amount = rand(1..10) * 100

      PromotionCode.create(code:, discount_amount:)
      puts "Generated code: #{code}, DiscountAmount: #{discount_amount}"
    end
  end
end
