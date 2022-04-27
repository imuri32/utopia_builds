class OrderItem < ApplicationRecord
  # Validations
  validates :quantity, numericality: true

  # Associations
  belongs_to :order
  belongs_to :product
end
