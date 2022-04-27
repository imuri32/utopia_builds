class RemoveHstFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :hst
  end
end
