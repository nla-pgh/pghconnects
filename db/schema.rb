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
    t.text     "institution"
    t.text     "focus"
    t.string   "credential"
    t.string   "school_id"
    t.date     "finish_on"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.string   "education_level"
  end

  create_table "emails", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "full"
  end

  create_table "events", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "start",       :null => false
    t.datetime "end",         :null => false
    t.text     "description", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "events_sites", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "site_id"
  end

  create_table "phones", :force => true do |t|
    t.string   "area"
    t.string   "carrier"
    t.string   "line"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "full"
  end

  create_table "sign_ups", :force => true do |t|
    t.boolean  "attended",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "event_id"
    t.integer  "user_id"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "abbr"
    t.string   "base_ip"
  end

  create_table "users", :force => true do |t|
    t.string   "first"
    t.string   "middle"
    t.string   "last"
    t.date     "birth_date"
    t.string   "registered_at"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "clearance_level"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
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
