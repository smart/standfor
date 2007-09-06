# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 8) do

  create_table "accounts", :force => true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "phone"
    t.string  "email"
    t.string  "address_1"
    t.string  "address_2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "country"
    t.date    "created_at"
    t.date    "updated_at"
    t.boolean "status",     :default => true
  end

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.integer  "segment_id"
    t.integer  "structure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", :force => true do |t|
    t.integer  "account_id"
    t.integer  "organization_id"
    t.integer  "amount"
    t.integer  "segment_id"
    t.integer  "billing_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "my_badges", :force => true do |t|
    t.integer  "badge_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string "description"
    t.date   "created_on"
    t.date   "updated_on"
    t.string "keyword"
  end

  create_table "requirements", :force => true do |t|
    t.integer "badge_id"
    t.string  "name"
    t.string  "value"
    t.string  "description"
    t.string  "type"
  end

  create_table "segments", :force => true do |t|
    t.string   "name"
    t.string   "keyword"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
