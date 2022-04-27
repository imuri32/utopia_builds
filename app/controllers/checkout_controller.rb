class CheckoutController < ApplicationController
  # GET /checkout, checkout
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    end

    if !session[:shopping_cart].empty?
      # Setting up products to utilize its info in cart, subtotal info, and user province
      items ||= []
      subtotal = 0

      session[:shopping_cart].each do |i|
        product = Product.find(i["id"])

        subtotal += product.price * i["qty"].to_i

        items << product
      end

      @items = items
      @subtotal = subtotal

      # Calculating sales tax
      province = Province.find(current_user.province_id)
      @pst = subtotal * province.pst
      @gst = subtotal * province.gst

      @total = @subtotal + @pst + @gst
    end
  end

  # POST /checkout/update, checkout_update
  def update
    id = params[:id].to_i
    qty = params[:qty].to_i

    if(qty > 0)
      product = Product.find(params[:id])
      found = session[:shopping_cart].select {|c| c["id"] == id}.first
      found["qty"] = qty
      found["price"] = product.price * qty.to_i

      flash[:notice] = "Updated #{product.name} to #{found["qty"].to_i} item(s) in cart."
    else
      product = Product.find(params[:id])
      flash[:alert] = "Error updating #{product.name}: Please include 1 or more items to add to the cart."
    end

    redirect_to checkout_path
  end

  # POST /checkout/remove, checkout_remove
  def remove
    logger.debug("***Trying to delete #{params[:id]} from cart.")
    id = params[:id].to_i
    session[:shopping_cart].delete_if { |c| c["id"] == id }

    product = Product.find(id)
    flash[:alert] = "#{product.name} removed from cart."
    redirect_to root_path
  end

  # POST /checkout/confirm, checkout_confirm
  def confirm
    order = Order.create(user_id: current_user.id)
    flash[:notice] = "Your order has been placed!"
    redirect_to root_path
  end
end
