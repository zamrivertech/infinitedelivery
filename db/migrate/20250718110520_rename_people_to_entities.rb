class RenamePeopleToEntities < ActiveRecord::Migration[8.0]
  def change
    rename_table :people, :entities
  end
end
