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

ActiveRecord::Schema.define(:version => 20110621134046) do

  create_table "attributes", :force => true do |t|
    t.string   "title",          :default => "",      :null => false
    t.string   "attribute_type", :default => "Trait", :null => false
    t.integer  "group_id",                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attributes", ["group_id"], :name => "index_attributes_on_group_id"

  create_table "bool_traits", :force => true do |t|
    t.boolean  "value",            :default => true, :null => false
    t.integer  "specification_id",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bool_traits", ["specification_id"], :name => "index_bool_traits_on_specification_id"

  create_table "groups", :force => true do |t|
    t.string   "title",      :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "measurements", :force => true do |t|
    t.decimal  "value",            :default => 0.0, :null => false
    t.integer  "specification_id",                  :null => false
    t.string   "unit",             :default => "",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "measurements", ["specification_id"], :name => "index_measurements_on_specification_id"

  create_table "products", :force => true do |t|
    t.string   "title",       :default => "", :null => false
    t.integer  "brand_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["brand_id"], :name => "index_products_on_brand_id"
  add_index "products", ["category_id"], :name => "index_products_on_category_id"

  create_table "specifications", :force => true do |t|
    t.integer  "product_id",       :null => false
    t.integer  "attribute_id",     :null => false
    t.integer  "specification_id"
    t.string   "format"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "specifications", ["attribute_id"], :name => "index_specifications_on_attribute_id"
  add_index "specifications", ["product_id"], :name => "index_specifications_on_product_id"
  add_index "specifications", ["specification_id"], :name => "index_specifications_on_specification_id"

  create_table "traits", :force => true do |t|
    t.string   "value",            :default => "", :null => false
    t.integer  "specification_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "traits", ["specification_id"], :name => "index_traits_on_specification_id"

end
