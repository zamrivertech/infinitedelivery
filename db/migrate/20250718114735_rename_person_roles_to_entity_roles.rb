class RenamePersonRolesToEntityRoles < ActiveRecord::Migration[8.0]
  def change
  rename_table :person_roles, :entity_roles
  end

end
