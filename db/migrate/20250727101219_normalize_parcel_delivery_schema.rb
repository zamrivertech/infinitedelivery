class NormalizeParcelDeliverySchema < ActiveRecord::Migration[8.0]
  def up
    # Add new columns to deliveries
    change_table :deliveries do |t|
      t.string  :delivery_priority
      t.date    :expected_delivery_date
      t.string  :tracking_status
      t.boolean :received_by_recipient
      t.string  :receipt_pdf_link
    end

    # Migrate data from parcels to deliveries
    Delivery.reset_column_information
    Parcel.find_each do |parcel|
      if parcel.delivery.present?
        delivery = parcel.delivery
        delivery.update!(
          delivery_priority:         parcel.delivery_priority,
          expected_delivery_date:    parcel.expected_delivery_date,
          tracking_status:           parcel.tracking_status,
          received_by_recipient:     parcel.received_by_recipient,
          receipt_pdf_link:          parcel.receipt_pdf_link
        )
      end
    end

    # Remove redundant columns from parcels
    remove_column :parcels, :delivery_type,              :string
    remove_column :parcels, :delivery_priority,          :string
    remove_column :parcels, :expected_delivery_date,     :date
    remove_column :parcels, :tracking_status,            :string
    remove_column :parcels, :received_by_recipient,      :boolean
    remove_column :parcels, :receipt_pdf_link,           :string
  end

  def down
    # Re-add removed columns to parcels (in case of rollback)
    change_table :parcels do |t|
      t.string  :delivery_type
      t.string  :delivery_priority
      t.date    :expected_delivery_date
      t.string  :tracking_status
      t.boolean :received_by_recipient
      t.string  :receipt_pdf_link
    end

    # Optionally, move data back to parcels if needed
    Parcel.reset_column_information
    Delivery.find_each do |delivery|
      parcel = delivery.parcel
      parcel.update!(
        delivery_priority:        delivery.delivery_priority,
        expected_delivery_date:   delivery.expected_delivery_date,
        tracking_status:          delivery.tracking_status,
        received_by_recipient:    delivery.received_by_recipient,
        receipt_pdf_link:         delivery.receipt_pdf_link
      )
    end

    # Remove new columns from deliveries
    remove_column :deliveries, :delivery_priority,        :string
    remove_column :deliveries, :expected_delivery_date,   :date
    remove_column :deliveries, :tracking_status,          :string
    remove_column :deliveries, :received_by_recipient,    :boolean
    remove_column :deliveries, :receipt_pdf_link,         :string
  end
end
