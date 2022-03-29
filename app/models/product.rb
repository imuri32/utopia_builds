class Product < ApplicationRecord
  # Validations

  # Associations
  belongs_to :product_types
  belongs_to :brands

  has_many :product_colors
  has_many :colors, through: :product_colors
end
