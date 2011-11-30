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

ActiveRecord::Schema.define(:version => 20111130214222) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.string   "artwork"
    t.string   "desc"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "artists", :force => true do |t|
    t.string   "bio"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "payment_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total"
  end

  create_table "payments", :force => true do |t|
    t.integer  "order_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "express_token"
    t.string   "express_payer_id"
  end

  create_table "songs", :force => true do |t|
    t.integer  "artist_id"
    t.string   "name"
    t.string   "album_name"
    t.string   "album_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "song_file_name"
    t.string   "song_content_type"
    t.integer  "song_file_size"
    t.datetime "song_updated_at"
    t.float    "price"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.string   "verify_token"
    t.integer  "status"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
