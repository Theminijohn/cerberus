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

ActiveRecord::Schema.define(version: 20140511100020) do

  create_table "alliances", primary_key: "grepo_id", force: true do |t|
    t.string   "name"
    t.integer  "points"
    t.integer  "town_count"
    t.integer  "member_count"
    t.integer  "rank"
    t.integer  "all_rank"
    t.integer  "all_points"
    t.integer  "def_rank"
    t.integer  "def_points"
    t.integer  "att_rank"
    t.integer  "att_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alliances", ["all_points"], name: "index_alliances_on_all_points"
  add_index "alliances", ["all_rank"], name: "index_alliances_on_all_rank"
  add_index "alliances", ["att_points"], name: "index_alliances_on_att_points"
  add_index "alliances", ["att_rank"], name: "index_alliances_on_att_rank"
  add_index "alliances", ["def_points"], name: "index_alliances_on_def_points"
  add_index "alliances", ["def_rank"], name: "index_alliances_on_def_rank"
  add_index "alliances", ["grepo_id"], name: "index_alliances_on_grepo_id"
  add_index "alliances", ["member_count"], name: "index_alliances_on_member_count"
  add_index "alliances", ["name"], name: "index_alliances_on_name"
  add_index "alliances", ["points"], name: "index_alliances_on_points"
  add_index "alliances", ["rank"], name: "index_alliances_on_rank"
  add_index "alliances", ["town_count"], name: "index_alliances_on_town_count"

  create_table "conquers", primary_key: "town_id", force: true do |t|
    t.integer  "time"
    t.integer  "new_player_id"
    t.integer  "old_player_id"
    t.integer  "new_ally_id"
    t.integer  "old_ally_id"
    t.integer  "town_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conquers", ["new_ally_id"], name: "index_conquers_on_new_ally_id"
  add_index "conquers", ["new_player_id"], name: "index_conquers_on_new_player_id"
  add_index "conquers", ["old_ally_id"], name: "index_conquers_on_old_ally_id"
  add_index "conquers", ["old_player_id"], name: "index_conquers_on_old_player_id"
  add_index "conquers", ["time"], name: "index_conquers_on_time"
  add_index "conquers", ["town_id"], name: "index_conquers_on_town_id"
  add_index "conquers", ["town_points"], name: "index_conquers_on_town_points"

  create_table "islands", primary_key: "grepo_id", force: true do |t|
    t.integer  "island_x"
    t.integer  "island_y"
    t.integer  "type_number"
    t.integer  "available_towns"
    t.string   "ocean"
    t.string   "coordinates"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "islands", ["available_towns"], name: "index_islands_on_available_towns"
  add_index "islands", ["coordinates"], name: "index_islands_on_coordinates"
  add_index "islands", ["grepo_id"], name: "index_islands_on_grepo_id"
  add_index "islands", ["island_x"], name: "index_islands_on_island_x"
  add_index "islands", ["island_y"], name: "index_islands_on_island_y"
  add_index "islands", ["ocean"], name: "index_islands_on_ocean"
  add_index "islands", ["type_number"], name: "index_islands_on_type_number"

  create_table "players", primary_key: "grepo_id", force: true do |t|
    t.string   "name"
    t.integer  "alliance_id"
    t.integer  "points"
    t.integer  "rank"
    t.integer  "town_count"
    t.integer  "all_rank"
    t.integer  "all_points"
    t.integer  "def_rank"
    t.integer  "def_points"
    t.integer  "att_rank"
    t.integer  "att_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["all_points"], name: "index_players_on_all_points"
  add_index "players", ["all_rank"], name: "index_players_on_all_rank"
  add_index "players", ["alliance_id"], name: "index_players_on_alliance_id"
  add_index "players", ["att_points"], name: "index_players_on_att_points"
  add_index "players", ["att_rank"], name: "index_players_on_att_rank"
  add_index "players", ["def_points"], name: "index_players_on_def_points"
  add_index "players", ["def_rank"], name: "index_players_on_def_rank"
  add_index "players", ["grepo_id"], name: "index_players_on_grepo_id"
  add_index "players", ["name"], name: "index_players_on_name"
  add_index "players", ["points"], name: "index_players_on_points"
  add_index "players", ["rank"], name: "index_players_on_rank"
  add_index "players", ["town_count"], name: "index_players_on_town_count"

  create_table "towns", primary_key: "grepo_id", force: true do |t|
    t.integer  "player_id"
    t.string   "name"
    t.integer  "island_x"
    t.integer  "island_y"
    t.integer  "slot"
    t.integer  "points"
    t.string   "ocean"
    t.string   "coordinates"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "towns", ["grepo_id"], name: "index_towns_on_grepo_id"
  add_index "towns", ["island_x"], name: "index_towns_on_island_x"
  add_index "towns", ["island_y"], name: "index_towns_on_island_y"
  add_index "towns", ["name"], name: "index_towns_on_name"
  add_index "towns", ["player_id"], name: "index_towns_on_player_id"
  add_index "towns", ["points"], name: "index_towns_on_points"
  add_index "towns", ["slot"], name: "index_towns_on_slot"

end
