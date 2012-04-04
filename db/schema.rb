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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120403141951) do

  create_table "addresses", :force => true do |t|
    t.integer  "number",           :null => false
    t.string   "street",           :null => false
    t.string   "apt_fl"
    t.string   "city",             :null => false
    t.string   "state",            :null => false
    t.string   "zip",              :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.integer  "household_number"
    t.float    "household_income"
  end

  create_table "educations", :force => true do |t|
    t.string   "institution"
    t.string   "focus"
    t.string   "credential"
    t.string   "school_id"
    t.date     "finish_on"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.string   "education_level"
  end

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.string   "domain"
    t.string   "root"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "full",       :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "start",       :null => false
    t.datetime "end",         :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "events_sites", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "site_id"
  end

  create_table "logins", :force => true do |t|
    t.datetime "time_stamp",          :null => false
    t.text     "login_name",          :null => false
    t.text     "domain"
    t.text     "ad_login_type"
    t.string   "client_addr",         :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "untangle_login_type", :null => false
    t.string   "login_index",         :null => false
    t.string   "resolution",          :null => false
  end

  add_index "logins", ["login_index"], :name => "index_logins_on_login_index", :unique => true

  create_table "logins_audits", :force => true do |t|
    t.datetime "time_stamp"
    t.string   "site"
    t.integer  "records_transfered"
    t.integer  "total_transfers"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "logins_audits", ["site"], :name => "index_logins_audits_on_site", :unique => true

  create_table "phones", :force => true do |t|
    t.string   "area"
    t.string   "carrier"
    t.string   "line"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "full",       :null => false
  end

  create_table "sign_ups", :force => true do |t|
    t.boolean  "attended",   :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "event_id"
    t.integer  "user_id"
  end

  create_table "sites", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "address",    :null => false
    t.string   "phone",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "abbr"
    t.string   "base_ip"
  end

  create_table "users", :force => true do |t|
    t.string   "first",                            :null => false
    t.string   "middle"
    t.string   "last",                             :null => false
    t.date     "birth_date",                       :null => false
    t.string   "registered_at",                    :null => false
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "clearance_level", :default => "U", :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "user_name"
    t.integer  "site_id"
    t.string   "password_digest"
  end

  add_index "users", ["user_name"], :name => "index_users_on_user_name", :unique => true

  create_table "work_histories", :force => true do |t|
    t.string   "business"
    t.date     "start"
    t.date     "end"
    t.text     "description"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

end
