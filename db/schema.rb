# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 50) do

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
    t.integer  "hits",                      :default => 0
    t.integer  "my_badge_referrer"
    t.string   "younety_token"
    t.integer  "total_hits",                :default => 0
    t.integer  "total_clicks",              :default => 0
    t.integer  "total_unique_hits",         :default => 0
    t.integer  "total_unique_clicks",       :default => 0
    t.integer  "awareness_points",          :default => 0
    t.datetime "stats_updated_at"
    t.string   "reset_password_code"
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

  create_table "avatars", :force => true do |t|
    t.integer  "account_id"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "size"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "width"
    t.integer  "height"
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
    t.string   "cached_tag_list"
    t.boolean  "featured",        :default => false
    t.integer  "hits",            :default => 0
  end

  create_table "campaigns", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "admin_id"
    t.integer  "segment_id"
    t.string   "name"
    t.text     "description"
    t.integer  "goal"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configurations", :force => true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.text     "welcome_message"
    t.text     "news"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", :force => true do |t|
    t.integer  "account_id"
    t.integer  "organization_id"
    t.integer  "amount"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
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
    t.string   "sponsorship_option"
    t.string   "merit_option"
    t.string   "public_adi_id"
    t.integer  "total_hits",          :default => 0
    t.integer  "total_clicks",        :default => 0
    t.integer  "total_unique_hits",   :default => 0
    t.integer  "total_unique_clicks", :default => 0
    t.integer  "awareness_points",    :default => 0
    t.datetime "stats_updated_at"
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

  create_table "orders", :force => true do |t|
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_four_digits"
    t.string   "payment_authorization"
    t.integer  "amount"
  end

  create_table "organizations", :force => true do |t|
    t.string  "name"
    t.string  "address1"
    t.string  "address2"
    t.string  "address3"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "country"
    t.string  "phone"
    t.string  "fax"
    t.string  "email"
    t.string  "url"
    t.string  "statement"
    t.text    "description"
    t.date    "created_on"
    t.date    "updated_on"
    t.string  "keyword"
    t.string  "site_name"
    t.integer "admin_id"
    t.boolean "featured",    :default => false
    t.text    "blog_url"
  end

  create_table "organizationslogos", :force => true do |t|
    t.string  "content_type"
    t.string  "filename"
    t.integer "size"
    t.integer "parent_id"
    t.string  "thumbnail"
    t.integer "width"
    t.integer "height"
    t.integer "organization_id"
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

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.string   "site_name"
    t.string   "logo"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "url"
    t.text     "statement"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.boolean  "featured",   :default => false
  end

  create_table "sponsorship_clicks", :force => true do |t|
    t.integer  "sponsorship_id"
    t.integer  "my_badge_id"
    t.boolean  "golden",             :default => false
    t.integer  "sponsorship_hit_id"
    t.string   "ip"
    t.string   "referrer"
    t.string   "cookies"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsorship_hits", :force => true do |t|
    t.integer  "my_badge_id"
    t.integer  "sponsorship_id"
    t.boolean  "golden",         :default => false
    t.string   "ip"
    t.string   "domain"
    t.string   "host"
    t.string   "referrer"
    t.string   "cookies"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsorships", :force => true do |t|
    t.integer "sponsor_id"
    t.integer "max_amount"
    t.date    "start_date"
    t.date    "end_date"
    t.integer "num_golden_links"
    t.float   "golden_link_rate"
    t.float   "click_rate"
    t.float   "unique_rate"
    t.float   "hit_rate"
    t.float   "awareness_point_rate"
    t.string  "type"
    t.integer "sponsorable_id"
    t.string  "sponsorable_type"
  end

  create_table "sponsorslogos", :force => true do |t|
    t.string  "content_type"
    t.string  "filename"
    t.integer "size"
    t.integer "parent_id"
    t.string  "thumbnail"
    t.integer "width"
    t.integer "height"
    t.integer "sponsor_id"
  end

  create_table "style_infos", :force => true do |t|
    t.string   "scope_type",       :default => "", :null => false
    t.integer  "scope_id",                         :null => false
    t.string   "color_primary",    :default => "", :null => false
    t.string   "color_secondary"
    t.string   "color_third"
    t.string   "color_standfor_1"
    t.string   "color_standfor_2"
    t.string   "color_header_1"
    t.string   "color_header_2"
    t.string   "color_button_1"
    t.string   "color_button_2"
    t.string   "color_fill_1"
    t.string   "color_fill_2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "youser_authenticators", :force => true do |t|
    t.string   "type"
    t.string   "email"
    t.integer  "account_id"
    t.integer  "facebook_uid"
    t.string   "facebook_session_key"
    t.string   "identity_url"
    t.string   "nickname"
    t.string   "fullname"
    t.string   "login"
    t.string   "crypted_password",     :limit => 40
    t.string   "salt",                 :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
