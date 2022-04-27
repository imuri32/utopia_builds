class Province < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :gst, numericality: true, allow_nil: true
  validates :pst, numericality: true, allow_nil: true

  # Associations
  has_many :users
end
