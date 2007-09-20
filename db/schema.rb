# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 100) do

  create_table "access_codes", :force => true do |t|
    t.integer "scope_id",                                  :null => false
    t.string  "scope_type", :default => "CodeRequirement", :null => false
    t.string  "value",      :default => "",                :null => false
  end

  create_table "access_codes_accounts", :id => false, :force => true do |t|
    t.integer "access_code_id"
    t.integer "account_id"
  end

  create_table "accounts", :force => true do |t|
    t.string   "phone"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.date     "created_at"
    t.date     "updated_at"
    t.boolean  "status",                    :default => true
    t.string   "fullname"
    t.string   "nickname"
    t.string   "primary_email"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

  create_table "accounts_roles", :id => false, :force => true do |t|
    t.integer "account_id"
    t.integer "role_id"
  end

  create_table "authenticators", :force => true do |t|
    t.string   "auth_type",  :default => "", :null => false
    t.string   "auth_token"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", :force => true do |t|
    t.integer  "badge_id"
    t.integer  "account_id"
    t.string   "authorization_code"
    t.string   "last_four_digits"
    t.boolean  "status",             :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.integer  "segment_id"
    t.integer  "structure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "campaign_id"
  end

  create_table "campaigns", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "segment_id"
    t.integer  "admin_id"
    t.integer  "goal"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", :force => true do |t|
    t.integer  "account_id"
    t.integer  "badge_id"
    t.integer  "organization_id"
    t.integer  "amount"
    t.integer  "segment_id"
    t.string   "payment_authorization"
    t.string   "last_four_digits",      :limit => 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "local_users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password", :limit => 40
    t.string   "salt",             :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "my_badges", :force => true do |t|
    t.integer  "badge_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "adi_id"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.binary  "server_url"
    t.string  "handle"
    t.binary  "secret"
    t.integer "issued"
    t.integer "lifetime"
    t.string  "assoc_type"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.string  "nonce"
    t.integer "created"
  end

  create_table "open_id_authentication_settings", :force => true do |t|
    t.string "setting"
    t.binary "value"
  end

  create_table "organizations", :force => true do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.string "phone"
    t.string "fax"
    t.string "email"
    t.string "url"
    t.string "statement"
    t.text   "description"
    t.date   "created_on"
    t.date   "updated_on"
    t.string "keyword"
    t.string "site_name"
  end

  create_table "requirements", :force => true do |t|
    t.integer "badge_id"
    t.string  "name"
    t.string  "value"
    t.string  "description"
    t.string  "type"
  end

  create_table "roles", :force => true do |t|
    t.string "title"
  end

  create_table "segments", :force => true do |t|
    t.string   "name"
    t.string   "keyword"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "site_name"
    t.text     "description"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
