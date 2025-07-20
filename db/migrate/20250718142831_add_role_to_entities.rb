class AddRoleToEntities < ActiveRecord::Migration[8.0]
  def change
  add_reference :entities, :role, foreign_key: true, null: true
  end
end
