class CreateDeliveries < ActiveRecord::Migration[8.0]
  def change
    create_table :deliveries do |t|
      t.references :parcel, null: false, foreign_key: true
      t.string :delivery_type
      t.datetime :arrived_at
      t.datetime :delivered_at
      t.string :proof_of_delivery
      t.string :delivery_status

      t.timestamps
    end
  end
end
