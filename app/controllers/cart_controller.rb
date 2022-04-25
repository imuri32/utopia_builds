class CartController < ApplicationController
  # POST /cart
  # Data is sent as form data (params)
  def create
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    qty = params[:qty].to_i

    unless session[:shopping_cart].include? (id)
      if(qty > 0)
        session[:shopping_cart] << id # Push id onto end of cart array
        session[:cart_qty] << {id: id, qty: qty}
        product = Product.find(params[:id])
        flash[:notice] = "#{qty} #{product.name}(s) added to cart."
      else
        product = Product.find(params[:id])
        flash[:alert] = "Error adding #{product.name}: Please include 1 or more items to add to the cart."
      end
    else
      if(qty > 0)
        found = session[:cart_qty].select {|c| c["id"] == id}.first
        found["qty"] = qty
        product = Product.find(params[:id])
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
    session[:shopping_cart].delete(id)
    session[:cart_qty].delete_if { |c| c["id"] == id }

    product = Product.find(id)
    flash[:alert] = "#{product.name} removed from cart."
    redirect_to root_path
  end

  def update
    id = params[:id].to_i
    flash[:notice] = "There are #{params[:qty]} item(s)."
    redirect_to root_path
  end
end
