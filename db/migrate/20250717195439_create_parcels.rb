class CreateParcels < ActiveRecord::Migration[8.0]
  def change
    create_table :parcels do |t|
      t.string :parcel_code
      t.string :parcel_type
      t.text :contents_description
      t.float :weight_kg
      t.string :dimensions_cm
      t.boolean :fragile
      t.boolean :insurance_required
      t.integer :value_mzn
      t.text :special_instructions
      t.string :delivery_type
      t.string :delivery_priority
      t.date :expected_delivery_date
      t.string :tracking_status
      t.boolean :received_by_recipient
      t.string :receipt_pdf_link
      t.text :internal_notes
      t.references :sender, foreign_key: { to_table: :people }
      t.references :recipient, foreign_key: { to_table: :people }
      t.references :registered_by, foreign_key: { to_table: :people }
      t.references :origin_branch, foreign_key: { to_table: :branches }
      t.references :destination_branch, foreign_key: { to_table: :branches }


      t.timestamps
    end
  end
end
