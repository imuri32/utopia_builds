class Order < ApplicationRecord
  # Validations
  validates :gst, numericality: true, allow_nil: true
  validates :pst, numericality: true, allow_nil: true
  validates :total, numericality: true, allow_nil: true

  # Associations
  belongs_to :user

  has_many :order_items
  has_many :products, through: :order_items
end
