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

ActiveRecord::Schema.define(:version => 20130411154608) do

  create_table "consumer_contacts", :force => true do |t|
    t.integer  "consumer_id"
    t.integer  "contact_id"
    t.string   "role"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.date     "deleted_at"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "consumer_contacts", ["consumer_id", "contact_id", "role"], :name => "index_consumer_contacts_on_consumer_id_and_contact_id_and_role", :unique => true
  add_index "consumer_contacts", ["consumer_id"], :name => "index_consumer_contacts_on_consumer_id"
  add_index "consumer_contacts", ["contact_id"], :name => "index_consumer_contacts_on_contact_id"

  create_table "consumers", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "identifier"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "deleted_at"
  end

  add_index "consumers", ["name"], :name => "index_consumers_on_name", :unique => true

  create_table "contacts", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "deleted_at"
  end

  add_index "contacts", ["name"], :name => "index_contacts_on_name", :unique => true

  create_table "providers", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "identifier"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "deleted_at"
  end

  add_index "providers", ["name"], :name => "index_providers_on_name", :unique => true

  create_table "services", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "category"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "provider_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "deleted_at"
  end

  add_index "services", ["name", "category"], :name => "index_services_on_name_and_category", :unique => true
  add_index "services", ["provider_id"], :name => "index_services_on_provider_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "service_id",  :null => false
    t.integer  "consumer_id", :null => false
    t.date     "starts_at"
    t.date     "ends_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "deleted_at"
  end

  add_index "subscriptions", ["consumer_id", "service_id"], :name => "index_subscriptions_on_consumer_id_and_service_id", :unique => true
  add_index "subscriptions", ["consumer_id"], :name => "index_subscriptions_on_consumer_id"
  add_index "subscriptions", ["service_id"], :name => "index_subscriptions_on_service_id"

  create_table "trashes", :force => true do |t|
    t.string   "trashable_name"
    t.string   "trashable_type"
    t.integer  "trashable_id"
    t.text     "trashable_data"
    t.datetime "created_at",                       :null => false
    t.integer  "transaction_id",    :default => 0, :null => false
    t.integer  "transaction_index", :default => 0, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",            :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "deleted_at"
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

end
