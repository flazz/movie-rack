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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110311044924) do

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.text     "tagline"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "showtimes", :force => true do |t|
    t.integer  "available_tickets"
    t.time     "playing_at"
    t.integer  "movie_id"
    t.integer  "theater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "theaters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
