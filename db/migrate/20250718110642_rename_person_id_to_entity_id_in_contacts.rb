class RenamePersonIdToEntityIdInContacts < ActiveRecord::Migration[8.0]
  def change
    rename_column :contacts, :person_id, :entity_id
    rename_column :person_roles, :person_id, :entity_id
  end
end
