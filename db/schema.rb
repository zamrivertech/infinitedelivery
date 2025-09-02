# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_06_134652) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address_type"
    t.string "street_line_1"
    t.string "street_line_2"
    t.string "neighborhood"
    t.string "city"
    t.string "region"
    t.string "postal_code"
    t.string "country"
    t.string "residency_status"
    t.float "latitude"
    t.float "longitude"
    t.bigint "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id"], name: "index_addresses_on_entity_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "province"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "entity_id", null: false
    t.string "contact_type"
    t.string "value"
    t.boolean "is_primary"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id"], name: "index_contacts_on_entity_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.bigint "parcel_id", null: false
    t.string "delivery_type"
    t.datetime "arrived_at"
    t.datetime "delivered_at"
    t.string "proof_of_delivery"
    t.string "delivery_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "delivery_priority"
    t.date "expected_delivery_date"
    t.string "tracking_status"
    t.boolean "received_by_recipient"
    t.string "receipt_pdf_link"
    t.index ["parcel_id"], name: "index_deliveries_on_parcel_id"
  end

  create_table "entities", force: :cascade do |t|
    t.string "full_name"
    t.string "nationality"
    t.string "id_type"
    t.string "id_number"
    t.string "gender"
    t.date "date_of_birth"
    t.string "place_of_birth"
    t.string "marital_status"
    t.integer "height_cm"
    t.string "issuance_country"
    t.string "issuance_location"
    t.date "issuance_date"
    t.date "expiry_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["role_id"], name: "index_entities_on_role_id"
  end

  create_table "entity_roles", force: :cascade do |t|
    t.bigint "entity_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id"], name: "index_entity_roles_on_entity_id"
    t.index ["role_id"], name: "index_entity_roles_on_role_id"
  end

  create_table "parcels", force: :cascade do |t|
    t.string "parcel_code"
    t.string "parcel_type"
    t.text "contents_description"
    t.float "weight_kg"
    t.string "dimensions_cm"
    t.boolean "fragile"
    t.boolean "insurance_required"
    t.integer "value_mzn"
    t.text "special_instructions"
    t.text "internal_notes"
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.bigint "origin_branch_id"
    t.bigint "destination_branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_branch_id"], name: "index_parcels_on_destination_branch_id"
    t.index ["origin_branch_id"], name: "index_parcels_on_origin_branch_id"
    t.index ["recipient_id"], name: "index_parcels_on_recipient_id"
    t.index ["sender_id"], name: "index_parcels_on_sender_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "parcel_id", null: false
    t.integer "transport_cost_mzn"
    t.integer "insurance_cost_mzn"
    t.integer "total_cost_mzn"
    t.string "status"
    t.string "method"
    t.string "payer_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parcel_id"], name: "index_payments_on_parcel_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "role_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  add_foreign_key "addresses", "entities"
  add_foreign_key "contacts", "entities"
  add_foreign_key "deliveries", "parcels"
  add_foreign_key "entities", "roles"
  add_foreign_key "entity_roles", "entities"
  add_foreign_key "entity_roles", "roles"
  add_foreign_key "parcels", "branches", column: "destination_branch_id"
  add_foreign_key "parcels", "branches", column: "origin_branch_id"
  add_foreign_key "parcels", "entities", column: "recipient_id"
  add_foreign_key "parcels", "entities", column: "sender_id"
  add_foreign_key "payments", "parcels"
end
