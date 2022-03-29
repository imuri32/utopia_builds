class Brand < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Associations
  has_many :products
end
