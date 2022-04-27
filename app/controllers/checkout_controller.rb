class CheckoutController < ApplicationController
  # GET /checkout, checkout
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    else
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

        # Calculating sales tax
        province = Province.find(current_user.province_id)

        session[:order] = {}

        pst = subtotal * province.pst
        gst = subtotal * province.gst

        session[:order]["pst"] = pst.round(2)
        session[:order]["gst"] = gst.round(2)
        session[:order]["subtotal"] = subtotal.round(2)
        session[:order]["total"] = (subtotal + pst + gst).round(2)
      end
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

  # POST /checkout/confirm, checkout_confirm
  def confirm
    order = Order.create(user_id: current_user.id)
    order.pst = session[:order]["pst"]
    order.gst = session[:order]["gst"]
    order.subtotal = session[:order]["subtotal"]
    order.total = session[:order]["total"]
    order.save

    session[:shopping_cart].each do |i|
      product = Product.find(i["id"].to_i)

      OrderItem.create(order_id: order.id, product_id: product.id, quantity: i["qty"].to_i)
    end

    session[:shopping_cart] = []
    flash[:notice] = "Your order has been placed!"

    redirect_to root_path
  end
end
