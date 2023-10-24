class BillingInfo < ApplicationRecord
  has_many :purchase_details, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :user_name, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :zip, presence: true, length: { is: 5 }
  validates :same_address_flag, presence: true
  validates :save_info_flag, presence: true
  validates :payment_method, presence: true
  validates :name_on_card, presence: true
  validates :credit_card_number, presence: true, length: { is: 16 }
  validates :credit_card_expiration, presence: true
  validates :credit_card_cvv, presence: true, length: { is: 3 }
end
