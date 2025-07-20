class CreatePersonRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :person_roles do |t|
      t.references :person, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
