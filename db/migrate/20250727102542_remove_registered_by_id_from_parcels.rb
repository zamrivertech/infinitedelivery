class RemoveRegisteredByIdFromParcels < ActiveRecord::Migration[8.0]
  def change
    remove_column :parcels, :registered_by_id, :bigint
  end
end
