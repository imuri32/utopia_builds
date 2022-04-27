ActiveAdmin.register OrderItem do
  permit_params :order_id, :product_id, :quantity

  form do |f|
    f.inputs do
      f.input :order_id, :as => :select, :collection => Order.all.collect {|order| [order.id, order.id] } # Shows id number as default dropdown value
      f.input :product_id, :as => :select, :collection => Product.all.collect {|product| [product.name, product.id] } # Shows id number as default dropdown value
      f.input :quantity
    end
    f.actions
  end
end
