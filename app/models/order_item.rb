class OrderItem < ApplicationRecord
  belongs_to :order
	belongs_to :item

	validates :amount,
			  		:price, presence: true
	validates :price, :amount, numericality: { only_integer: true }

	enum is_production: {"production_not_allowed": 0,"waiting_for_production": 1,"aiting_for_production": 2,"prduction_conpleted": 3}
end
