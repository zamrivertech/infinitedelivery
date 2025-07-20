class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :parcel, null: false, foreign_key: true
      t.integer :transport_cost_mzn
      t.integer :insurance_cost_mzn
      t.integer :total_cost_mzn
      t.string :status
      t.string :method
      t.string :payer_type

      t.timestamps
    end
  end
end
