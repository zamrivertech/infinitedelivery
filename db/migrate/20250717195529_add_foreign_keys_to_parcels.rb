class AddForeignKeysToParcels < ActiveRecord::Migration[8.0]
  def change
    # Only add foreign key if it's missing
    add_foreign_key :parcels, :people, column: :sender_id, on_delete: :nullify unless foreign_key_exists?(:parcels, column: :sender_id)
    add_foreign_key :parcels, :people, column: :recipient_id, on_delete: :nullify unless foreign_key_exists?(:parcels, column: :recipient_id)
    add_foreign_key :parcels, :people, column: :registered_by_id, on_delete: :nullify unless foreign_key_exists?(:parcels, column: :registered_by_id)
    add_foreign_key :parcels, :branches, column: :origin_branch_id, on_delete: :nullify unless foreign_key_exists?(:parcels, column: :origin_branch_id)
    add_foreign_key :parcels, :branches, column: :destination_branch_id, on_delete: :nullify unless foreign_key_exists?(:parcels, column: :destination_branch_id)
  end
end
