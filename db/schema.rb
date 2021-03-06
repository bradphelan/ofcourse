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

ActiveRecord::Schema.define(:version => 20110216001311) do

  create_table "admin_users", :force => true do |t|
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                                 :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 25
    t.string   "guid",              :limit => 10
    t.integer  "locale",            :limit => 1,  :default => 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "fk_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_assetable_type"
  add_index "ckeditor_assets", ["user_id"], :name => "fk_user"

  create_table "course_registrations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "course_id"
  end

  create_table "courses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "user_id"
    t.text     "description"
  end

  add_index "courses", ["user_id"], :name => "index_courses_on_user_id"

  create_table "events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_at",    :null => false
    t.integer  "schedule_id"
    t.datetime "end_at",      :null => false
    t.string   "name"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "roles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        :limit => 25,  :null => false
    t.string   "description", :limit => 140
  end

  create_table "rooms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       :null => false
  end

  create_table "schedules", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "end_date",                                        :null => false
    t.boolean  "monday",                       :default => false
    t.boolean  "tuesday",                      :default => false
    t.boolean  "wednesday",                    :default => false
    t.boolean  "thursday",                     :default => false
    t.boolean  "friday",                       :default => false
    t.boolean  "saturday",                     :default => false
    t.boolean  "sunday",                       :default => false
    t.integer  "course_id"
    t.string   "period",                                          :null => false
    t.integer  "room_id",                                         :null => false
    t.datetime "start_date",                                      :null => false
    t.integer  "start_seconds_since_midnight",                    :null => false
    t.integer  "end_seconds_since_midnight",                      :null => false
    t.integer  "duration",                                        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",   :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",   :null => false
    t.string   "password_salt",                       :default => "",   :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                                               :null => false
    t.boolean  "status",                              :default => true, :null => false
    t.text     "preferences"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
