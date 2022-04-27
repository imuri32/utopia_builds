class CartController < ApplicationController
  # POST /cart
  # Data is sent as form data (params)
  def create
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    qty = params[:qty].to_i

    # Adds to cart if cart is empty or not empty and selected item from cart does not exist yet
    if session[:shopping_cart].select {|c| c["id"] == id}.first.nil?
      if(qty > 0)
        # Grabbing product to obtain base item price and name
        product = Product.find(params[:id])

        session[:shopping_cart] << {id: id, qty: qty, price: (product.price * qty.to_i)}
        flash[:notice] = "#{qty} #{product.name}(s) added to cart."
      else
        product = Product.find(params[:id])
        flash[:alert] = "Error adding #{product.name}: Please include 1 or more items to add to the cart."
      end
    else
      if(qty > 0)
        # Grabbing product to obtain base item price and name
        product = Product.find(params[:id])
        found = session[:shopping_cart].select {|c| c["id"] == id}.first
        found["qty"] = qty
        found["price"] = (product.price * qty.to_i)

        flash[:notice] = "Updated #{product.name} to #{found["qty"].to_i} item(s) in cart."
      else
        product = Product.find(params[:id])
        flash[:alert] = "Error updating #{product.name}: Please include 1 or more items to add to the cart."
      end
    end

    logger.debug("Shopping cart: #{session[:shopping_cart].inspect}")
    redirect_to root_path
  end

  # DELETE /cart/:id
  def destroy
    logger.debug("***Trying to delete #{params[:id]} from cart.")
    id = params[:id].to_i
    session[:shopping_cart].delete_if { |c| c["id"] == id }

    product = Product.find(id)
    flash[:alert] = "#{product.name} removed from cart."
    redirect_to root_path
  end
end
