# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081114065002) do

  create_table "age_levels", :force => true do |t|
    t.string   "title"
    t.integer  "from_age"
    t.integer  "to_age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.string   "transcrib"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lft"
    t.integer  "rgt"
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "author"
    t.integer  "post"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cycles", :force => true do |t|
    t.integer  "workout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "day_lines", :force => true do |t|
    t.integer  "day_id"
    t.integer  "exercise_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "workout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_number"
    t.integer  "cycle_id"
    t.integer  "muscular_group_id"
  end

  create_table "days_muscular_groups", :id => false, :force => true do |t|
    t.integer "day_id"
    t.integer "muscular_group_id"
  end

  create_table "difficult_levels", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercise_sets", :force => true do |t|
    t.integer  "day_line_id"
    t.integer  "weight"
    t.integer  "repetitions"
    t.integer  "time_rest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", :force => true do |t|
    t.string   "title"
    t.string   "image_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "first_image_id"
    t.integer  "middle_image_id"
    t.integer  "last_image_id"
    t.integer  "strength_type_id"
  end

  create_table "exercises_gym_appartus", :id => false, :force => true do |t|
    t.integer "exercise_id"
    t.integer "gym_appartus_id"
  end

  create_table "exercises_images", :id => false, :force => true do |t|
    t.integer "exercise_id"
    t.integer "image_id"
  end

  create_table "exercises_muscular_groups", :id => false, :force => true do |t|
    t.integer "exercise_id"
    t.integer "muscular_group_id"
  end

  create_table "friendships", :force => true do |t|
    t.string   "a"
    t.string   "b"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gym_appartus", :force => true do |t|
    t.integer  "occupacy_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images_gym_appartus", :id => false, :force => true do |t|
    t.integer "image_id"
    t.integer "gym_appartus_id"
  end

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "muscles", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "muscular_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "muscular_groups", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupacies", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orderings", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "status"
    t.string   "login"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.text     "address"
    t.text     "extra"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "author"
    t.integer  "replies"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "rolename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.integer  "parent_id"
  end

  create_table "strength_types", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "systems", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "top_menus", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_modes", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_access_actions", :force => true do |t|
    t.integer  "user_role"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "controller"
  end

  create_table "user_access_cs", :force => true do |t|
    t.integer  "user_role"
    t.string   "controller"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "password_reset_code",       :limit => 40
    t.boolean  "enabled",                                 :default => true
    t.integer  "role"
    t.string   "name"
    t.string   "phone"
    t.text     "address"
  end

  create_table "users_workouts", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "workout_id"
  end

  create_table "week_days", :force => true do |t|
    t.string   "title"
    t.string   "short_name"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workout_items", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workouts", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "difficult_level_id"
    t.string   "gender",             :limit => 1
    t.integer  "age_level_id"
    t.integer  "goal_id"
    t.integer  "occupacy_id"
    t.integer  "training_mode_id"
    t.boolean  "is_complete"
  end

  create_table "wsets", :force => true do |t|
    t.integer  "weight"
    t.integer  "repetitions"
    t.integer  "day_line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
