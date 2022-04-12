class Province < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Associations
  has_many :users
end
