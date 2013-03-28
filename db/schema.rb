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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130325172023) do

  create_table "employee_skills", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "skill_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "proficiency", :default => 0
  end

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "group"
    t.string   "location"
    t.string   "current_project"
    t.string   "department"
    t.string   "supervisor"
    t.integer  "years_at_company"
    t.string   "description"
    t.string   "job_title"
  end

  add_index "employees", ["remember_token"], :name => "index_employees_on_remember_token"

  create_table "request_skills", :force => true do |t|
    t.integer  "request_id"
    t.integer  "skill_id"
    t.integer  "skills_needed"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "employee_id"
    t.string   "group"
    t.string   "location"
    t.string   "skills_needed"
    t.date     "start_date"
    t.date     "stop_date"
    t.string   "content"
    t.string   "client"
    t.string   "project"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "active"
  end

  create_table "responses", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "request_id"
    t.string   "response"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "selections", :force => true do |t|
    t.integer  "request_id"
    t.integer  "employee_id"
    t.string   "comments"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "response_id"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "target_skills", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "skill_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "interest_level", :default => 0
  end

end
