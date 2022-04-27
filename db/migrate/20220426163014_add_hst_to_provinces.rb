class AddHstToProvinces < ActiveRecord::Migration[7.0]
  def change
    add_column :provinces, :hst, :decimal
  end
end
