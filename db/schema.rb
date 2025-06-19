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

ActiveRecord::Schema[8.0].define(version: 2025_06_15_194622) do
  create_table "accounts", force: :cascade do |t|
    t.text "title", null: false
    t.text "color", null: false
    t.integer "initial_amount_cents", default: 0, null: false
    t.boolean "archived", default: false, null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archived", "position"], name: "index_accounts_on_archived_and_position"
  end

  create_table "categories", force: :cascade do |t|
    t.text "title", null: false
    t.text "color", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_categories_on_position"
  end

  create_table "records", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "transfer_id"
    t.integer "category_id"
    t.integer "group", null: false
    t.integer "amount_cents", default: 0, null: false
    t.date "occurred_on", null: false
    t.text "note", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "occurred_on", "created_at"], name: "index_records_on_account_id_and_occurred_on_and_created_at", order: { occurred_on: :desc, created_at: :desc }
    t.index ["account_id"], name: "index_records_on_account_id"
    t.index ["category_id"], name: "index_records_on_category_id"
    t.index ["occurred_on"], name: "index_records_on_occurred_on", order: :desc
    t.index ["transfer_id"], name: "index_records_on_transfer_id"
  end

  create_table "reminder_monthly_configs", force: :cascade do |t|
    t.integer "day", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reminder_occurrences", force: :cascade do |t|
    t.integer "reminder_id", null: false
    t.integer "record_id"
    t.date "occurs_on", null: false
    t.text "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id"], name: "index_reminder_occurrences_on_record_id"
    t.index ["reminder_id"], name: "index_reminder_occurrences_on_reminder_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.text "title", null: false
    t.integer "group", null: false
    t.integer "account_id", null: false
    t.integer "category_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.text "note", default: "", null: false
    t.string "config_type", null: false
    t.integer "config_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_reminders_on_account_id"
    t.index ["category_id"], name: "index_reminders_on_category_id"
    t.index ["config_type", "config_id"], name: "index_reminders_on_config"
    t.index ["title"], name: "index_reminders_on_title", unique: true
  end

  create_table "templates", force: :cascade do |t|
    t.text "title", null: false
    t.integer "group", null: false
    t.integer "account_id", null: false
    t.integer "category_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.text "note"
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_templates_on_account_id"
    t.index ["category_id"], name: "index_templates_on_category_id"
    t.index ["position"], name: "index_templates_on_position"
    t.index ["title"], name: "index_templates_on_title", unique: true
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "from_account_id", null: false
    t.integer "to_account_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.date "occurred_on", null: false
    t.text "note", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_account_id"], name: "index_transfers_on_from_account_id"
    t.index ["to_account_id"], name: "index_transfers_on_to_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "email", null: false
    t.text "encrypted_password", limit: 128, null: false
    t.text "confirmation_token", limit: 128
    t.text "remember_token", limit: 128, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

  add_foreign_key "records", "accounts"
  add_foreign_key "records", "categories"
  add_foreign_key "records", "transfers"
  add_foreign_key "reminder_occurrences", "records"
  add_foreign_key "reminder_occurrences", "reminders"
  add_foreign_key "reminders", "accounts"
  add_foreign_key "reminders", "categories"
  add_foreign_key "templates", "accounts"
  add_foreign_key "templates", "categories"
  add_foreign_key "transfers", "accounts", column: "from_account_id"
  add_foreign_key "transfers", "accounts", column: "to_account_id"
end
