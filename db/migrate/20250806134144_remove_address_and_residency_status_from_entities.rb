class RemoveAddressAndResidencyStatusFromEntities < ActiveRecord::Migration[8.0]
  def change
    remove_column :entities, :address, :string
    remove_column :entities, :residence_status, :string
  end
end
