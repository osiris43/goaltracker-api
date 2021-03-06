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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150319021420) do

  create_table "activities", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goal_units", force: :cascade do |t|
    t.string   "description", limit: 255
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "unit_id"
    t.integer  "timeframe_id"
    t.integer  "measurement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goals", ["activity_id"], name: "index_goals_on_activity_id"
  add_index "goals", ["timeframe_id"], name: "index_goals_on_timeframe_id"
  add_index "goals", ["unit_id"], name: "index_goals_on_unit_id"

  create_table "progress_events", force: :cascade do |t|
    t.integer  "number"
    t.integer  "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "progress_events", ["goal_id"], name: "index_progress_events_on_goal_id"

  create_table "progresses", force: :cascade do |t|
    t.integer  "progress"
    t.integer  "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "progresses", ["goal_id"], name: "index_progresses_on_goal_id"

  create_table "timeframes", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
