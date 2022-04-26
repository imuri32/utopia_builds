class Order < ApplicationRecord
  # Associations
  belongs_to :user

  has_many :order_items
  has_many :products
end
