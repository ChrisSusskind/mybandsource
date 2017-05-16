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

ActiveRecord::Schema.define(version: 20170516210929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string   "picture"
    t.index ["genre_id"], name: "index_artists_on_genre_id", using: :btree
    t.index ["location"], name: "index_artists_on_location", using: :btree
    t.index ["name"], name: "index_artists_on_name", using: :btree
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_genres_on_name", unique: true, using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "generating_user_id",                      null: false
    t.integer  "receiving_user_id"
    t.integer  "receiving_artist_id"
    t.integer  "review_id"
    t.integer  "response_id"
    t.string   "notification_type"
    t.boolean  "viewed",                  default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "generating_user_name",                    null: false
    t.string   "generating_user_picture"
    t.index ["generating_user_id"], name: "index_notifications_on_generating_user_id", using: :btree
    t.index ["receiving_artist_id"], name: "index_notifications_on_receiving_artist_id", using: :btree
    t.index ["receiving_user_id"], name: "index_notifications_on_receiving_user_id", using: :btree
    t.index ["response_id"], name: "index_notifications_on_response_id", using: :btree
    t.index ["review_id"], name: "index_notifications_on_review_id", using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "upvotes",          default: 0
    t.text     "upvotes_userlist", default: [],              array: true
    t.text     "comment",                       null: false
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["review_id"], name: "index_responses_on_review_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id",                       null: false
    t.integer  "artist_id",                     null: false
    t.integer  "rating",           default: -1
    t.integer  "upvotes",          default: 0
    t.text     "upvotes_userlist", default: [],              array: true
    t.index ["artist_id"], name: "index_reviews_on_artist_id", using: :btree
    t.index ["user_id", "artist_id"], name: "index_reviews_on_user_id_and_artist_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "artist_id", null: false
    t.index ["artist_id"], name: "index_subscriptions_on_artist_id", using: :btree
    t.index ["user_id", "artist_id"], name: "index_subscriptions_on_user_id_and_artist_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "user_relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_user_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_user_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_user_relationships_on_follower_id", using: :btree
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name",                   default: "", null: false
    t.string   "location"
    t.string   "picture"
    t.text     "bio",                    default: ""
    t.string   "provider"
    t.string   "uid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["location"], name: "index_users_on_location", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "notifications", "artists", column: "receiving_artist_id"
  add_foreign_key "notifications", "responses"
  add_foreign_key "notifications", "reviews"
  add_foreign_key "notifications", "users", column: "generating_user_id"
  add_foreign_key "notifications", "users", column: "receiving_user_id"
end
