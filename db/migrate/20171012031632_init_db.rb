class InitDb < ActiveRecord::Migration
  def change
  	  create_table "accounts" do |t|
	    t.string   "nickname"
	    t.string   "mobile"
	    t.integer  "status",                 :default => 0,     :null => false
	    t.string   "token"
	    t.integer  "province_id",           
	    t.integer  "city_id",               
	    t.integer  "district_id",            
	    t.string   "address"
	    t.string   "password_digest"
	    t.text     "roles"
	    t.text     "description"
	    t.text     "log"
	    t.datetime "created_at",                                :null => false
	    t.datetime "updated_at",                                :null => false
	  end

	  add_index "accounts", ["nickname"], :name => "index_accounts_on_nickname", :unique => true 

	  create_table "addresses", force: true do |t|
	    t.integer  "user_id",        comment: "所属用户"
	    t.string   "consignee_name", comment: "收货人姓名"
	    t.string   "postal_code",    comment: "邮编"
	    t.string   "street",         comment: "街道地址"
	    t.string   "mobile",         comment: "手机"
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
	    t.boolean "published",      default: true, comment: "是否有效"
	    t.string  "pet"
	    t.string  "pcc_ids"
	    t.string  "pcc_names"
	  end

	  create_table "roles", force: true do |t|
	    t.string   "name"
	    t.string   "desc"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	  end

	  create_table "account_roles", force: true do |t|
	    t.integer  "account_id"
	    t.integer  "role_id"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	  end

	  create_table "role_permissions", force: true do |t|
	    t.integer  "role_id"
	    t.integer  "permission_id"
	    t.datetime "created_at",    null: false
	    t.datetime "updated_at",    null: false
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

  end
end
