class ProductsController < ApplicationController
  def index
    @recent_product = Product.last

    ProductType.all.each do | type |
      instance_variable_set("@recent #{type.name}".squish.downcase.tr(' ', '_'), Product.where(product_type_id: type.id).order(:created_at).last)
    end

    @products = Product.search(params[:search], params[:brand]).page params[:page]

    @brands = Brand.order('lower(name)').all

    if params[:brand]
      @brand = Brand.find_by(id: params[:brand])
    end
  end

  def show
    @product = Product.find(params[:id])

    add_breadcrumb "Home".html_safe, root_path
    add_breadcrumb "Brands".html_safe, brands_path
    add_breadcrumb "#{@product.brand.name}".html_safe, brand_path(@product.brand.id)
    add_breadcrumb "#{@product.name}".html_safe, product_path(params[:id])
  end

  private
  def brands_params
    params.require(:product).permit(:search, :country)
  end
end