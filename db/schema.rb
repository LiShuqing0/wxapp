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

ActiveRecord::Schema.define(version: 20170830091134) do

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
