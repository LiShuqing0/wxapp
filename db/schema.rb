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

ActiveRecord::Schema.define(version: 20171221101759) do

  create_table "account_roles", force: true do |t|
    t.integer  "account_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: true do |t|
    t.string   "nickname"
    t.string   "mobile"
    t.integer  "status",          default: 0, null: false
    t.string   "token"
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "district_id"
    t.string   "address"
    t.string   "password_digest"
    t.text     "roles"
    t.text     "description"
    t.text     "log"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "accounts", ["nickname"], name: "index_accounts_on_nickname", unique: true, using: :btree

  create_table "addresses", force: true do |t|
    t.integer  "user_id"
    t.string   "consignee_name"
    t.string   "postal_code"
    t.string   "street"
    t.string   "mobile"
    t.integer  "area_id"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "county"
    t.string   "city"
    t.string   "province"
    t.boolean  "is_main"
  end

  add_index "addresses", ["area_id"], name: "index_addresses_on_area_id", using: :btree
  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "areas", force: true do |t|
    t.string  "code"
    t.string  "name"
    t.string  "ancestry"
    t.integer "ancestry_depth", default: 0
    t.string  "remark"
    t.boolean "published",      default: true
    t.string  "pet"
    t.string  "pcc_ids"
    t.string  "pcc_names"
  end

  create_table "articles", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "abstract"
    t.text     "body"
    t.integer  "status",     default: 1
    t.integer  "position"
    t.boolean  "published",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flows", force: true do |t|
    t.integer  "settlement_id"
    t.integer  "user_id"
    t.integer  "category",                               default: 1
    t.string   "title"
    t.integer  "paytype",                                default: 1
    t.decimal  "price",         precision: 15, scale: 6, default: 0.0
    t.decimal  "qty",           precision: 15, scale: 6, default: 0.0
    t.decimal  "amount",        precision: 10, scale: 2, default: 0.0
    t.integer  "index_day"
    t.integer  "index_month"
    t.integer  "index_year"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: true do |t|
    t.integer  "subject_id"
    t.string   "subject_class"
    t.string   "action"
    t.string   "name"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "ancestry"
    t.boolean  "is_menu",                  default: false
    t.string   "url"
    t.float    "order_num",     limit: 24, default: 999.0
  end

  create_table "role_permissions", force: true do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settlements", force: true do |t|
    t.integer  "user_id"
    t.integer  "category",                             default: 1
    t.decimal  "amount",      precision: 10, scale: 2, default: 0.0
    t.decimal  "month_left",  precision: 10, scale: 2, default: 0.0
    t.decimal  "year_left",   precision: 10, scale: 2, default: 0.0
    t.integer  "index_day"
    t.integer  "index_month"
    t.integer  "index_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "wx_user_id"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.string   "reset_digest"
    t.integer  "status"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.string   "current_sign_in_ip"
    t.datetime "last_sign_in_at"
    t.string   "last_sign_in_ip"
    t.integer  "error_count"
    t.datetime "reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wx_users", force: true do |t|
    t.integer  "status",         default: 1, null: false
    t.string   "openid",                     null: false
    t.string   "nickName"
    t.integer  "gender",         default: 0
    t.string   "language"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "avatarUrl"
    t.string   "unionid"
    t.string   "remark"
    t.string   "location_x"
    t.string   "location_y"
    t.string   "location_label"
    t.string   "session_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
