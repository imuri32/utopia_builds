class RemoveHstFromProvinces < ActiveRecord::Migration[7.0]
  def change
    remove_column :provinces, :hst
  end
end
