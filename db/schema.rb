# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141221140930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "datafiles", force: :cascade do |t|
    t.string   "name"
    t.string   "checksum"
    t.bigint   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "locations_count", default: 0
    t.index ["checksum"], name: "index_datafiles_on_checksum", using: :btree
  end

  create_table "datastores", force: :cascade do |t|
    t.string   "name"
    t.string   "mediatype"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "locations_count", default: 0
  end

  create_table "locations", force: :cascade do |t|
    t.string   "path"
    t.string   "name"
    t.datetime "last_modified"
    t.integer  "datastore_id"
    t.integer  "datafile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["datafile_id"], name: "index_locations_on_datafile_id", using: :btree
    t.index ["datastore_id"], name: "index_locations_on_datastore_id", using: :btree
  end

  create_table "metadata", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "datafile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["datafile_id", "key"], name: "index_metadata_on_datafile_id_and_key", using: :btree
    t.index ["datafile_id", "key"], name: "missing_datafile_key", using: :btree
    t.index ["datafile_id"], name: "index_metadata_on_datafile_id", using: :btree
    t.index ["id", "key"], name: "missing_metakey", using: :btree
    t.index ["key"], name: "missing_key", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "authentication_token"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

end
