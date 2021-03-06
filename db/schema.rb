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

ActiveRecord::Schema.define(version: 20150417093129) do

  create_table "formations", force: true do |t|
    t.string   "type_name",      null: false
    t.string   "title",          null: false
    t.string   "css_title",      null: false
    t.text     "image_position", null: false
    t.text     "text_position",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maintenances", force: true do |t|
    t.integer  "valid_st",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_counters", force: true do |t|
    t.integer  "qid",        null: false
    t.integer  "pid",        null: false
    t.integer  "num",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_counters", ["qid"], name: "index_player_counters_on_qid", using: :btree

  create_table "player_types", force: true do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.integer  "type_id",    null: false
    t.string   "full_name",  null: false
    t.string   "short_name", null: false
    t.integer  "valid_st",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "title",                 null: false
    t.string   "description",           null: false
    t.text     "valid_player_type_ids", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "valid_st",              null: false
  end

  create_table "user_comments", force: true do |t|
    t.integer  "image_id",   null: false
    t.string   "comment",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_comments", ["image_id"], name: "index_user_comments_on_image_id", using: :btree

  create_table "user_post_images", force: true do |t|
    t.integer  "question_id",             null: false
    t.string   "image_name",              null: false
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "point",       default: 0
  end

  add_index "user_post_images", ["point"], name: "index_user_post_images_on_point", using: :btree
  add_index "user_post_images", ["question_id", "point"], name: "index_user_post_images_on_question_id_and_point", using: :btree

  create_table "user_question_requests", force: true do |t|
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_twitter_post_images", force: true do |t|
    t.integer  "uid",        null: false
    t.integer  "image_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_twitter_post_images", ["uid"], name: "index_user_twitter_post_images_on_uid", using: :btree

end
