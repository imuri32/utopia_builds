class OrdersController < ApplicationController
  def index
    add_breadcrumb "Home".html_safe, root_path
    add_breadcrumb "My Orders".html_safe, orders_path

    if(!user_signed_in?)
      redirect_to new_user_session_path
    end

    user = User.find(current_user.id)

    @orders = user.orders
  end

  def show
    @order = Order.find(params[:id])

    add_breadcrumb "Home".html_safe, root_path
    add_breadcrumb "My Orders".html_safe, orders_path
    add_breadcrumb "Order on #{@order.created_at.strftime("%B %d, %Y")}".html_safe, order_path(params[:id])

    @items = OrderItem.where(order_id: @order.id)
  end
end
