# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_11_26_225303) do
  create_table "base_models", force: :cascade do |t|
    t.string "name", null: false
    t.string "company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fine_tunes", force: :cascade do |t|
    t.string "name"
    t.integer "base_model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_model_id"], name: "index_fine_tunes_on_base_model_id"
  end

  create_table "provider_links", force: :cascade do |t|
    t.integer "provider_id", null: false
    t.string "linkable_type", null: false
    t.integer "linkable_id", null: false
    t.string "view_link"
    t.string "source_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linkable_type", "linkable_id"], name: "index_provider_links_on_linkable"
    t.index ["linkable_type", "linkable_id"], name: "index_provider_links_on_linkable_type_and_linkable_id"
    t.index ["provider_id"], name: "index_provider_links_on_provider_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "renders", force: :cascade do |t|
    t.string "render_type"
    t.float "guidance_scale"
    t.integer "steps"
    t.integer "num_outputs"
    t.text "prompt", null: false
    t.integer "status", default: 0
    t.string "modelable_type", null: false
    t.integer "modelable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modelable_type", "modelable_id"], name: "index_renders_on_modelable"
    t.index ["modelable_type", "modelable_id"], name: "index_renders_on_modelable_type_and_modelable_id"
  end

  add_foreign_key "fine_tunes", "base_models"
  add_foreign_key "provider_links", "providers"
end
