class CreatePeople < ActiveRecord::Migration[8.0]
  def change
    create_table :people do |t|
      t.string :full_name
      t.string :nationality
      t.string :id_type
      t.string :id_number
      t.string :gender
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :marital_status
      t.integer :height_cm
      t.string :address
      t.string :issuance_country
      t.string :issuance_location
      t.date :issuance_date
      t.date :expiry_date
      t.string :residence_status

      t.timestamps
    end
  end
end
