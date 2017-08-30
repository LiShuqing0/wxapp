class InitUser < ActiveRecord::Migration
  def change
  	create_table :wx_users do |t|
      t.integer  "status",                  :default => 1,     :null => false
      t.string   "openid",                                     :null => false
      t.string   "nickName"
      t.integer  "gender",                     :default => 0
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
      t.string   "unionid"
      t.timestamps
    end

    create_table :users do |t|
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
      t.timestamps
    end
  end
end
