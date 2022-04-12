class Province < ApplicationRecord
  # Validations
  validates :name, presence: true
end
