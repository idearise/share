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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120109044005) do

  create_table "apps", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.text     "about"
    t.text     "thanks_to"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "google_plus"
    t.string   "android"
    t.string   "itunes"
    t.integer  "user_id"
    t.integer  "created_by"
    t.string   "created_ip",  :limit => 39
    t.integer  "updated_by"
    t.string   "updated_ip",  :limit => 39
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apps", ["created_at"], :name => "index_apps_on_created_at"
  add_index "apps", ["created_by"], :name => "index_apps_on_created_by"
  add_index "apps", ["updated_at"], :name => "index_apps_on_updated_at"
  add_index "apps", ["updated_by"], :name => "index_apps_on_updated_by"

  create_table "client_platforms", :force => true do |t|
    t.integer  "platform_id"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_platforms", ["created_at"], :name => "index_client_platforms_on_created_at"
  add_index "client_platforms", ["updated_at"], :name => "index_client_platforms_on_updated_at"

  create_table "platforms", :force => true do |t|
    t.string   "name"
    t.integer  "display_order", :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["provider", "uid"], :name => "index_services_on_provider_and_uid", :unique => true
  add_index "services", ["user_id"], :name => "index_services_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",       :limit => 64
    t.string   "email"
    t.string   "avatar",     :limit => 64
    t.string   "nickname",   :limit => 32
    t.string   "twitter",    :limit => 32
    t.string   "linkedin",   :limit => 64
    t.string   "facebook",   :limit => 64
    t.string   "google",     :limit => 64
    t.text     "bio"
    t.string   "last_ip",    :limit => 39
    t.integer  "created_by"
    t.string   "created_ip", :limit => 39
    t.integer  "updated_by"
    t.string   "updated_ip", :limit => 39
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["created_by", "updated_by"], :name => "index_users_on_created_by_and_updated_by"
  add_index "users", ["last_ip"], :name => "index_users_on_last_ip"

end
