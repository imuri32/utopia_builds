class AddPstToProvinces < ActiveRecord::Migration[7.0]
  def change
    add_column :provinces, :pst, :decimal
  end
end
