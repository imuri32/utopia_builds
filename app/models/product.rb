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

  has_many :order_items
  has_many :orders

  has_one_attached :image

  private
  def self.search(search, brand)
    if !brand.blank?
      brand_selected = Brand.find_by(id: brand)

      if brand_selected
        if !search.blank?
          self.where(brand_id: brand).where("name LIKE ?", "%#{search}%")
        else
          self.where(brand_id: brand)
        end
      else
        Product.all
      end
    elsif search
      wildcard_search = "%#{search}%"
      self.where("name LIKE ?", wildcard_search)
    else
      Product.all
    end
  end
end
