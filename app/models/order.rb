class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  validates :customer_id, :address,:name, :postage,
            :total_price, :payment_method,
         presence: true
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  validates :postage, :total_price, numericality: { only_integer: true }

  enum payment_method: {"credit_card": 0,"transfer": 1}
  enum st_order: {"waiting_for_payment": 0,"payment_confirmation": 1,"production": 2,"shipping_preparation": 3, "deposited": 4}
end
