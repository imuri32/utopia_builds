class AddGstToProvinces < ActiveRecord::Migration[7.0]
  def change
    add_column :provinces, :gst, :decimal
  end
end
