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

ActiveRecord::Schema[8.0].define(version: 2025_06_12_232343) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.string "use"
    t.string "address_type"
    t.string "line", default: [], array: true
    t.string "city"
    t.string "district"
    t.string "state"
    t.string "postal_code"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practitioner_id"], name: "index_addresses_on_practitioner_id"
  end

  create_table "communications", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.string "language_code"
    t.boolean "preferred"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practitioner_id"], name: "index_communications_on_practitioner_id"
  end

  create_table "contact_informations", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.string "system"
    t.string "value"
    t.string "use"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practitioner_id"], name: "index_contact_informations_on_practitioner_id"
  end

  create_table "credentials", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.string "system"
    t.string "value"
    t.string "use"
    t.string "credential_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practitioner_id"], name: "index_credentials_on_practitioner_id"
  end

  create_table "names", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.string "use"
    t.string "prefix", default: [], array: true
    t.string "given", default: [], array: true
    t.string "suffix", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "family"
    t.string "#<ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition"
    t.index ["practitioner_id"], name: "index_names_on_practitioner_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.string "url"
    t.string "content_type"
    t.integer "size"
    t.string "file_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practitioner_id"], name: "index_photos_on_practitioner_id"
  end

  create_table "practitioners", force: :cascade do |t|
    t.string "external_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.string "gender"
    t.date "birth_date"
    t.string "pronouns"
    t.string "status_reason"
    t.string "employment_type"
    t.string "department"
    t.string "nationality"
    t.jsonb "extensions"
  end

  create_table "qualification_identifiers", force: :cascade do |t|
    t.bigint "qualification_id", null: false
    t.string "system"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qualification_id"], name: "index_qualification_identifiers_on_qualification_id"
  end

  create_table "qualifications", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.string "code"
    t.date "start_date"
    t.date "end_date"
    t.string "issuer_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practitioner_id"], name: "index_qualifications_on_practitioner_id"
  end

  create_table "recurring_work_hours", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.integer "weekday", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recurrence_pattern"
    t.date "recurrence_end_date"
    t.string "timezone"
    t.jsonb "recurrence_rules"
    t.string "event_type"
    t.string "appointment_type"
    t.index ["schedule_id"], name: "index_recurring_work_hours_on_schedule_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.string "category", null: false
    t.date "start_date"
    t.date "end_date"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_type"
    t.string "appointment_type"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "timezone"
    t.index ["practitioner_id"], name: "index_schedules_on_practitioner_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.boolean "available", default: true
    t.string "source_type"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practitioner_id", "start_time"], name: "index_slots_on_practitioner_id_and_start_time", unique: true
    t.index ["practitioner_id"], name: "index_slots_on_practitioner_id"
  end

  create_table "time_exceptions", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "exception_type", null: false
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone"
    t.jsonb "recurrence_rules", default: {}, null: false
    t.string "event_type"
    t.string "appointment_type"
    t.index ["schedule_id"], name: "index_time_exceptions_on_schedule_id"
  end

  add_foreign_key "addresses", "practitioners"
  add_foreign_key "communications", "practitioners"
  add_foreign_key "contact_informations", "practitioners"
  add_foreign_key "credentials", "practitioners"
  add_foreign_key "names", "practitioners"
  add_foreign_key "photos", "practitioners"
  add_foreign_key "qualification_identifiers", "qualifications"
  add_foreign_key "qualifications", "practitioners"
  add_foreign_key "recurring_work_hours", "schedules"
  add_foreign_key "schedules", "practitioners"
  add_foreign_key "slots", "practitioners"
  add_foreign_key "time_exceptions", "schedules"
end
