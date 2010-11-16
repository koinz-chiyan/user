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

ActiveRecord::Schema.define(:version => 20101030000000) do

  create_table "admins", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "hashed_password", :null => false
    t.string   "salt",            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true

  create_table "client_sessions", :force => true do |t|
    t.string   "client_id",  :null => false
    t.string   "auth_token", :null => false
    t.datetime "expiration", :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "name",          :null => false
    t.string   "client_id",     :null => false
    t.string   "client_secret", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["client_id"], :name => "index_clients_on_client_id", :unique => true

  create_table "end_user_sessions", :force => true do |t|
    t.string   "user_email", :null => false
    t.string   "auth_token", :null => false
    t.datetime "expiration", :null => false
  end

  create_table "end_users", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "hashed_password",                    :null => false
    t.string   "salt",                               :null => false
    t.string   "facebook_snid"
    t.string   "first_name",                         :null => false
    t.string   "last_name",                          :null => false
    t.boolean  "verified",        :default => false, :null => false
    t.datetime "last_logged_in",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "end_users", ["email"], :name => "index_end_users_on_email", :unique => true
  add_index "end_users", ["facebook_snid"], :name => "index_end_users_on_facebook_snid", :unique => true

end
