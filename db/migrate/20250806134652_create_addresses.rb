class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string   :address_type               # e.g. 'home', 'pickup', etc.
      t.string   :street_line_1
      t.string   :street_line_2
      t.string   :neighborhood
      t.string   :city
      t.string   :region                     # province/state
      t.string   :postal_code
      t.string   :country
      t.string   :residency_status           # now a plain string, form-driven
      t.float    :latitude                   # optional, for mapping and location logic
      t.float    :longitude
      t.references :entity, foreign_key: true, index: true

      t.timestamps
    end
  end
end
