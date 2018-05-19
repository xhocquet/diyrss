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

ActiveRecord::Schema.define(version: 2018_05_19_221405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_monitors", force: :cascade do |t|
    t.text "url"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "selector"
    t.integer "latest_result_id"
    t.index ["url"], name: "index_app_monitors_on_url"
  end

  create_table "monitor_results", force: :cascade do |t|
    t.bigint "app_monitor_id"
    t.text "payload"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_monitor_id"], name: "index_monitor_results_on_app_monitor_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id", null: false
    t.integer "action", default: 0
    t.integer "relevant_thing_id"
    t.string "relevant_thing_type"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id"
  end

  create_table "user_categories", force: :cascade do |t|
    t.text "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_monitors", force: :cascade do |t|
    t.text "name"
    t.text "url"
    t.integer "status", default: 0
    t.bigint "app_monitor_id"
    t.bigint "user_id"
    t.bigint "user_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_viewed"
    t.integer "last_viewed_result_id"
    t.index ["app_monitor_id"], name: "index_user_monitors_on_app_monitor_id"
    t.index ["user_category_id"], name: "index_user_monitors_on_user_category_id"
    t.index ["user_id"], name: "index_user_monitors_on_user_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.boolean "notify_email", default: true
    t.boolean "notify_site", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
