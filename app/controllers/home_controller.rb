class HomeController < ApplicationController
  def index
    @recent_product = Product.last

    ProductType.all.each do | type |
      instance_variable_set("@recent #{type.name}".squish.downcase.tr(' ', '_'), Product.where(product_type_id: type.id).order(:created_at).last)
    end
  end
end
