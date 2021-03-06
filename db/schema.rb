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

ActiveRecord::Schema.define(:version => 20120922160904) do

  create_table "categories", :force => true do |t|
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "position"
    t.string   "slug"
    t.string   "name_fr"
    t.string   "name_en"
  end

  add_index "categories", ["category_id"], :name => "index_categories_on_category_id"
  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "category_pictures", :force => true do |t|
    t.integer "position"
    t.integer "category_id"
    t.integer "picture_id"
  end

  add_index "category_pictures", ["category_id", "picture_id"], :name => "index_category_pictures_on_category_id_and_picture_id"

  create_table "news", :force => true do |t|
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "title_fr"
    t.string   "title_en"
    t.text     "content_fr"
    t.text     "content_en"
    t.boolean  "published",  :default => false
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.string   "slug"
    t.integer  "position"
    t.boolean  "online",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "pages", ["online"], :name => "index_pages_on_online"
  add_index "pages", ["slug"], :name => "index_pages_on_slug"

  create_table "picture_informations", :force => true do |t|
    t.string "name_fr"
    t.string "name_en"
    t.string "type"
  end

  create_table "pictures", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name"
    t.text     "description"
    t.integer  "news_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.date     "year"
    t.float    "price"
    t.float    "selling_price"
    t.integer  "support_id"
    t.integer  "collection_id"
    t.integer  "location_id"
    t.integer  "dimension_id"
    t.integer  "technic_id"
    t.integer  "material_id"
    t.string   "dimension_extra"
    t.string   "technic_extra"
    t.string   "support_extra"
    t.string   "collection_extra"
    t.string   "material_extra"
    t.string   "location_extra"
    t.text     "personal_note"
  end

  create_table "users", :force => true do |t|
    t.string   "full_name",              :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
