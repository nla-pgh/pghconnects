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

ActiveRecord::Schema.define(:version => 20120327200636) do

  create_table "users", :force => true do |t|
    t.string   "first",            :null => false
    t.string   "middle"
    t.string   "last",             :null => false
    t.date     "birth_date",       :null => false
    t.string   "registered_at",    :null => false
    t.string   "gender"
    t.string   "ethnicity"
    t.integer  "household_number", :null => false
    t.float    "household_income", :null => false
    t.string   "education_level",  :null => false
    t.string   "clearance_level",  :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "user_name"
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
  end

end
