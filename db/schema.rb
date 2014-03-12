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

ActiveRecord::Schema.define(version: 20140312142849) do

  create_table "mailing_lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["parent_id"], name: "index_organizations_on_parent_id"

  create_table "subscribers", force: true do |t|
    t.integer  "user_id"
    t.integer  "mailing_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscribers", ["mailing_list_id"], name: "index_subscribers_on_mailing_list_id"
  add_index "subscribers", ["user_id"], name: "index_subscribers_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
