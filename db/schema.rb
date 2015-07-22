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

ActiveRecord::Schema.define(version: 20150722061232) do

  create_table "stations", force: :cascade do |t|
    t.text     "data_dump"
    t.integer  "station_id"
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "long"
    t.integer  "dockcount"
    t.string   "landmark"
    t.date "installation"
    t.text     "notes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "trips", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "duration"
    t.datetime "start_date"
    t.string   "start_station"
    t.integer  "start_terminal"
    t.datetime "end_date"
    t.string   "end_station"
    t.integer  "end_terminal"
    t.integer  "bike_id"
    t.string   "subscriber_type"
    t.string   "zip_code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "weathers", force: :cascade do |t|
    t.date     "date"
    t.integer  "max_temperature_f"
    t.integer  "mean_temperature_f"
    t.integer  "min_temperature_f"
    t.integer  "max_dewpoint_f"
    t.integer  "mean_dewpoint_f"
    t.integer  "min_dewpoint_f"
    t.integer  "max_humidity"
    t.integer  "mean_humidity"
    t.integer  "min_humidity"
    t.decimal  "max_sea_level_pressure_in"
    t.decimal  "mean_sea_level_pressure_in"
    t.decimal  "min_sea_level_pressure_in"
    t.integer  "max_visibility_miles"
    t.integer  "mean_visibility_miles"
    t.integer  "min_visibility_miles"
    t.integer  "max_wind_speed_mph"
    t.integer  "mean_wind_speed_mph"
    t.integer  "max_gust_speed_mph"
    t.decimal  "precipitation_in"
    t.integer  "cloud_cover"
    t.string  "events"
    t.integer  "wind_dir_degrees"
    t.string   "zip_code"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
