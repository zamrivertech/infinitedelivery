class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.references :person, null: false, foreign_key: true
      t.string :contact_type
      t.string :value
      t.boolean :is_primary
      t.boolean :verified

      t.timestamps
    end
  end
end
