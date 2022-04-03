class Product < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :price, numericality: true, allow_nil: true
  validates :rating, numericality: true, allow_nil: true

  # Associations
  belongs_to :product_type
  belongs_to :brand

  has_many :product_colors
  has_many :colors, through: :product_colors

  has_one_attached :image
end
