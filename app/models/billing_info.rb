# frozen_string_literal: true

class BillingInfo < ApplicationRecord
  has_many :purchase_details, dependent: :destroy
  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :user_name
    validates :address
    validates :country
    validates :state
    validates :payment_method
    validates :name_on_card
    validates :credit_card_expiration
  end
  validates :zip, presence: true, length: { is: 5 }
  validates :credit_card_number, presence: true, length: { is: 16 }
  validates :credit_card_cvv, presence: true, length: { is: 3 }
end
