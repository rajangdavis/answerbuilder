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

ActiveRecord::Schema.define(version: 20160620210607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.string   "language"
    t.string   "series"
    t.text     "tagline"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "translation_status"
    t.string   "translation_needed"
    t.string   "title_jp"
    t.text     "tagline_jp"
    t.integer  "rightnow_answer_id"
  end

  add_index "answers", ["user_id"], name: "index_user_id", using: :btree

  create_table "steps", force: true do |t|
    t.integer  "number"
    t.text     "step"
    t.text     "image"
    t.string   "image_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "answer_id"
    t.string   "step_type"
    t.integer  "offset"
    t.string   "image_upload_file_name"
    t.string   "image_upload_content_type"
    t.integer  "image_upload_file_size"
    t.datetime "image_upload_updated_at"
    t.text     "step_jp"
    t.string   "image_upload_jp_file_name"
    t.string   "image_upload_jp_content_type"
    t.integer  "image_upload_jp_file_size"
    t.datetime "image_upload_jp_updated_at"
  end

  add_index "steps", ["answer_id"], name: "index_answer_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

end
