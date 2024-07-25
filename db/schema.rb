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

ActiveRecord::Schema[7.1].define(version: 20_240_724_100_754) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'purchase_items', force: :cascade do |t|
    t.bigint 'purchase_id'
    t.string 'name'
    t.float 'price'
    t.date 'expiration_date'
    t.float 'quantity'
    t.string 'unit'
    t.string 'item_type'
    t.string 'verifi_id'
    t.json 'verifi_metadata'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.date 'deleted_at'
    t.boolean 'used', default: false
    t.boolean 'has_no_expiry', default: false
    t.index ['purchase_id'], name: 'index_purchase_items_on_purchase_id'
  end

  create_table 'purchases', force: :cascade do |t|
    t.string 'store_name', null: false
    t.float 'billing_amount', null: false
    t.float 'partial_amount'
    t.string 'purchase_type'
    t.date 'purchase_date', null: false
    t.string 'store_logo', default: 'https://storage.cloud.google.com/refrigerator_receipts/supermarket-logo.jpeg'
    t.string 'verifi_id'
    t.jsonb 'verifi_metadata'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.date 'deleted_at'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'purchase_items', 'purchases'
end
