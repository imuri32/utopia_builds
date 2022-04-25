class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  before_action :initialize_session
  helper_method :cart

  private
  # this will initialize the visit counter to zero for new users
  def initialize_session
    session[:shopping_cart] ||= []   #||= sets default values in ruby, empty array of product IDs in this case
    session[:cart_qty] ||= []
  end

  # retrieve a collection of products from a collection
  def cart
    Product.find(session[:shopping_cart])
  end

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:province_id, :address, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:province_id, :address, :email, :password, :current_password)}
  end
end
