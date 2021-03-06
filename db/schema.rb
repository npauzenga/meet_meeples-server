# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160131181506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_nights", force: :cascade do |t|
    t.datetime "time"
    t.string   "location_name"
    t.string   "location_address"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "group_id"
    t.string   "name"
  end

  add_index "game_nights", ["group_id"], name: "index_game_nights_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "facebook"
    t.string   "twitter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "user_game_night_attendances", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_night_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_game_night_attendances", ["game_night_id"], name: "index_user_game_night_attendances_on_game_night_id", using: :btree
  add_index "user_game_night_attendances", ["user_id"], name: "index_user_game_night_attendances_on_user_id", using: :btree

  create_table "user_group_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_group_memberships", ["group_id"], name: "index_user_group_memberships_on_group_id", using: :btree
  add_index "user_group_memberships", ["user_id"], name: "index_user_group_memberships_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "email_confirmed"
    t.string   "confirm_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.string   "country"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "game_nights", "groups"
  add_foreign_key "user_game_night_attendances", "game_nights"
  add_foreign_key "user_game_night_attendances", "users"
  add_foreign_key "user_group_memberships", "groups"
  add_foreign_key "user_group_memberships", "users"
end
