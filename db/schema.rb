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

ActiveRecord::Schema.define(version: 20170725061532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.date     "date",       null: false
    t.time     "time",       null: false
    t.integer  "client_id"
    t.integer  "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_appointments_on_client_id", using: :btree
    t.index ["staff_id"], name: "index_appointments_on_staff_id", using: :btree
  end

  create_table "appointments_services", force: :cascade do |t|
    t.integer  "appointment_id"
    t.integer  "services_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["appointment_id"], name: "index_appointments_services_on_appointment_id", using: :btree
    t.index ["services_id"], name: "index_appointments_services_on_services_id", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "phone_number",                        null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_clients_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "duration",   null: false
    t.float    "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "phone_number", null: false
    t.integer  "store_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["store_id"], name: "index_staffs_on_store_id", using: :btree
  end

  create_table "stores", force: :cascade do |t|
    t.string   "location"
    t.string   "hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
