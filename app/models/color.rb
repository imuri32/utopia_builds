class Color < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Associations
  has_many :product_colors
  has_many :products, through: :product_colors
end
