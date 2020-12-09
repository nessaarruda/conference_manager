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


ActiveRecord::Schema.define(version: 2020_12_08_004904) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"


  create_table "meeting_rooms", force: :cascade do |t|
    t.string "name"
    t.boolean "has_projector"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string "name"
    t.integer "number_of_participants"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "meeting_room_id"
    t.datetime "start_time"
    t.datetime "end_time"
  end
  
  create_table "conferences", force: :cascade do |t|
    t.string "name"
    t.string "organization"
    t.integer "size"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
  end

  create_table "presentations", force: :cascade do |t|
    t.string "name"
    t.string "presenter"
    t.string "category"
    t.boolean "projector_needed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "conference_id"
    t.index ["conference_id"], name: "index_presentations_on_conference_id"
  end

  add_foreign_key "presentations", "conferences"
end
