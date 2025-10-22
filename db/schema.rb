# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_21_084920) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.string "name", null: false
    t.string "icon"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_amenities_on_category"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "user_id", null: false
    t.date "check_in", null: false
    t.date "check_out", null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.integer "status", default: 0
    t.integer "guests_count"
    t.text "special_requests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id", "check_in", "check_out"], name: "index_bookings_on_property_id_and_check_in_and_check_out"
    t.index ["property_id"], name: "index_bookings_on_property_id"
    t.index ["status"], name: "index_bookings_on_status"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_favorites_on_property_id"
    t.index ["user_id", "property_id"], name: "index_favorites_on_user_id_and_property_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti", unique: true
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.string "cloudinary_id"
    t.string "url", null: false
    t.integer "position", default: 0
    t.boolean "is_primary", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id", "position"], name: "index_photos_on_property_id_and_position"
    t.index ["property_id"], name: "index_photos_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
    t.string "location"
    t.string "city"
    t.string "country"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.decimal "price_per_night", precision: 10, scale: 2, null: false
    t.integer "property_type", default: 0
    t.integer "bedrooms"
    t.integer "bathrooms"
    t.integer "guests"
    t.integer "status", default: 0
    t.boolean "featured", default: false
    t.integer "reviews_count", default: 0
    t.decimal "average_rating", precision: 3, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["average_rating"], name: "index_properties_on_average_rating"
    t.index ["city", "status"], name: "index_properties_on_city_and_status"
    t.index ["featured"], name: "index_properties_on_featured"
    t.index ["property_type"], name: "index_properties_on_property_type"
    t.index ["status"], name: "index_properties_on_status"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "property_amenities", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "amenity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_property_amenities_on_amenity_id"
    t.index ["property_id", "amenity_id"], name: "index_property_amenities_on_property_id_and_amenity_id", unique: true
    t.index ["property_id"], name: "index_property_amenities_on_property_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "user_id", null: false
    t.decimal "rating", precision: 3, scale: 2, null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id", "user_id"], name: "index_reviews_on_property_id_and_user_id", unique: true
    t.index ["property_id"], name: "index_reviews_on_property_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.integer "role", default: 0
    t.string "avatar_url"
    t.text "bio"
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "bookings", "properties"
  add_foreign_key "bookings", "users"
  add_foreign_key "favorites", "properties"
  add_foreign_key "favorites", "users"
  add_foreign_key "photos", "properties"
  add_foreign_key "properties", "users"
  add_foreign_key "property_amenities", "amenities"
  add_foreign_key "property_amenities", "properties"
  add_foreign_key "reviews", "properties"
  add_foreign_key "reviews", "users"
end
