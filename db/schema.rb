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

ActiveRecord::Schema.define(version: 20180108130902) do

  create_table "calendars", force: :cascade do |t|
    t.date     "day"
    t.integer  "price"
    t.integer  "status"
    t.integer  "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_calendars_on_food_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string   "cuisine_type"
    t.string   "entree_type"
    t.integer  "portions_available"
    t.string   "listing_name"
    t.text     "summary"
    t.string   "address"
    t.boolean  "organic"
    t.boolean  "vegan"
    t.boolean  "vegetarian"
    t.boolean  "gluten_free"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.integer  "price"
    t.boolean  "milk"
    t.boolean  "eggs"
    t.boolean  "chicken"
    t.boolean  "redmeat"
    t.boolean  "fish"
    t.boolean  "other"
    t.string   "ingredients"
    t.string   "types_of_diets"
    t.string   "diets"
    t.boolean  "other_diets"
    t.boolean  "active"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "instant",            default: 1
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "order_foods", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "food_id"
    t.float    "price"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "quantity_per_day"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "food_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "price"
    t.integer  "total"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.time     "time_pickup"
    t.integer  "portion_number"
    t.integer  "status",         default: 0
    t.string   "stripe_id"
    t.index ["food_id"], name: "index_orders_on_food_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "food_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["food_id"], name: "index_photos_on_food_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.integer  "star",       default: 1
    t.integer  "food_id"
    t.integer  "order_id"
    t.integer  "chef_id"
    t.integer  "foodie_id"
    t.string   "type"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["chef_id"], name: "index_reviews_on_chef_id"
    t.index ["food_id"], name: "index_reviews_on_food_id"
    t.index ["foodie_id"], name: "index_reviews_on_foodie_id"
    t.index ["order_id"], name: "index_reviews_on_order_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fullname"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "phone_number"
    t.text     "description"
    t.string   "pin"
    t.boolean  "phone_verified"
    t.string   "stripe_id"
    t.string   "merchant_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
