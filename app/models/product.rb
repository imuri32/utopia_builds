class Product < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Associations
  belongs_to :product_type
  belongs_to :brand

  has_many :product_colors
  has_many :colors, through: :product_colors
end
