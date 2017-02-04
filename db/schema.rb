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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170204231738) do

  create_table "artists", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "real_name"
    t.text     "profile"
    t.string   "data_quality",   null: false
    t.string   "location"
    t.string   "facebook_url"
    t.string   "soundcloud_url"
    t.string   "spotify_url"
    t.string   "itunes_url"
    t.string   "twitter_url"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "genre_id"
    t.index ["genre_id"], name: "index_artists_on_genre_id"
    t.index ["location"], name: "index_artists_on_location"
    t.index ["name"], name: "index_artists_on_name"
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.integer  "rating_1"
    t.integer  "rating_2"
    t.integer  "rating_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
    t.integer  "artist_id",  null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "artist_id", null: false
    t.index ["artist_id"], name: "index_subscriptions_on_artist_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "location"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["location"], name: "index_users_on_location"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
