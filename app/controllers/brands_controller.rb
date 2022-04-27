class BrandsController < ApplicationController
  def index
    add_breadcrumb "Home".html_safe, root_path
    add_breadcrumb "Brands".html_safe, brands_path

    @brands = Brand.order('lower(name)').all.page(params[:page]).per(20)
  end

  def show
    @brand = Brand.find(params[:id])

    add_breadcrumb "Home".html_safe, root_path
    add_breadcrumb "Brands".html_safe, brands_path
    add_breadcrumb "#{@brand.name}", brand_path(params[:id])

    @brand_products = Product.where(brand_id: @brand.id)
  end
end
