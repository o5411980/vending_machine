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

ActiveRecord::Schema.define(version: 2021_10_13_121446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_authorizers_on_document_id"
    t.index ["user_id"], name: "index_authorizers_on_user_id"
  end

  create_table "authors", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_authors_on_document_id"
    t.index ["user_id"], name: "index_authors_on_user_id"
  end

  create_table "department_leaders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_department_leaders_on_department_id"
    t.index ["user_id"], name: "index_department_leaders_on_user_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.integer "location"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "filepath"
    t.integer "category"
    t.integer "control_number"
    t.boolean "authorize"
    t.bigint "product_id"
    t.index ["product_id"], name: "index_documents_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.string "description"
    t.integer "status"
    t.integer "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_users_on_project_id"
    t.index ["user_id"], name: "index_project_users_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "review_documents", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_review_documents_on_document_id"
    t.index ["review_id"], name: "index_review_documents_on_review_id"
  end

  create_table "reviewers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_reviewers_on_review_id"
    t.index ["user_id"], name: "index_reviewers_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "requester"
    t.integer "stage"
    t.text "description"
    t.integer "former_review"
    t.datetime "date_on"
    t.datetime "deadline"
    t.boolean "judge", default: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "name"
    t.integer "mr_ms"
    t.integer "employee_number"
    t.string "icon"
    t.text "comment"
    t.text "admin_message"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "authorizers", "documents"
  add_foreign_key "authorizers", "users"
  add_foreign_key "authors", "documents"
  add_foreign_key "authors", "users"
  add_foreign_key "department_leaders", "departments"
  add_foreign_key "department_leaders", "users"
  add_foreign_key "documents", "products"
  add_foreign_key "project_users", "projects"
  add_foreign_key "project_users", "users"
  add_foreign_key "review_documents", "documents"
  add_foreign_key "review_documents", "reviews"
  add_foreign_key "reviewers", "reviews"
  add_foreign_key "reviewers", "users"
end
