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

ActiveRecord::Schema.define(version: 2019_03_01_143023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_tokens", force: :cascade do |t|
    t.string "value"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.string "name"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id", "recipient_id"], name: "index_conversations_on_sender_id_and_recipient_id", unique: true
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "messageable_id"
    t.string "messageable_type"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["messageable_id"], name: "index_messages_on_messageable_id"
    t.index ["messageable_type"], name: "index_messages_on_messageable_type"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "destination_id"
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relations", force: :cascade do |t|
    t.integer "related_id"
    t.integer "relating_id"
    t.integer "state", default: 0
    t.index ["related_id", "relating_id"], name: "index_relations_on_related_id_and_relating_id", unique: true
    t.index ["related_id"], name: "index_relations_on_related_id"
    t.index ["relating_id"], name: "index_relations_on_relating_id"
  end

  create_table "user_chats", force: :cascade do |t|
    t.integer "user_id"
    t.integer "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 2
    t.index ["chat_id"], name: "index_user_chats_on_chat_id"
    t.index ["user_id", "chat_id"], name: "index_user_chats_on_user_id_and_chat_id", unique: true
    t.index ["user_id"], name: "index_user_chats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "number"
    t.string "address"
    t.date "date"
    t.text "about"
    t.string "country"
    t.string "locate"
    t.index ["first_name", "last_name"], name: "index_users_on_first_name_and_last_name"
  end

  create_table "walls", force: :cascade do |t|
    t.string "wallable_type"
    t.integer "wallable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wallable_id"], name: "index_walls_on_wallable_id"
    t.index ["wallable_type"], name: "index_walls_on_wallable_type"
  end

end
