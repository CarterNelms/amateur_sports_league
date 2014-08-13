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

ActiveRecord::Schema.define(version: 201408121610) do

  create_table "memberships", force: true do |t|
    t.integer "team_id"
    t.integer "player_id"
    t.integer "sport_id"
  end

  create_table "players", force: true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "username"
    t.integer "age"
    t.integer "is_male"
    t.integer "teams_id"
    t.integer "sports_id"
    t.integer "memberships_id"
  end

  create_table "sports", force: true do |t|
    t.string  "name"
    t.integer "minimum_team_size",       default: 0
    t.integer "maximum_team_size",       default: 100
    t.integer "minimum_number_of_teams", default: 0
    t.integer "maximum_number_of_teams", default: 100
    t.integer "teams_id"
  end

  create_table "teams", force: true do |t|
    t.string  "name"
    t.integer "sport_id"
    t.integer "players_id"
    t.integer "captain_id"
    t.integer "memberships_id"
  end

end
