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

ActiveRecord::Schema.define(version: 2019_02_25_202659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.bigint "user_id"
    t.bigint "account_type_id"
    t.bigint "bank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "currency_id", default: 1
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id"
    t.index ["bank_id"], name: "index_accounts_on_bank_id"
    t.index ["currency_id"], name: "index_accounts_on_currency_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "balances", force: :cascade do |t|
    t.date "date"
    t.integer "amount"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_balances_on_account_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "bik"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "short"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_plans", force: :cascade do |t|
    t.date "date"
    t.integer "amount"
    t.bigint "expense_type_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_type_id"], name: "index_expense_plans_on_expense_type_id"
  end

  create_table "expense_rows", force: :cascade do |t|
    t.bigint "expense_id"
    t.bigint "expense_type_id"
    t.integer "amount"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_expense_rows_on_expense_id"
    t.index ["expense_type_id"], name: "index_expense_rows_on_expense_type_id"
  end

  create_table "expense_types", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "expense_kind_id"
    t.index ["expense_kind_id"], name: "index_expense_types_on_expense_kind_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.date "date"
    t.bigint "shop_id"
    t.integer "amount"
    t.bigint "account_id"
    t.bigint "expense_type_id"
    t.bigint "user_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "report_amount", default: 0
    t.index ["account_id"], name: "index_expenses_on_account_id"
    t.index ["expense_type_id"], name: "index_expenses_on_expense_type_id"
    t.index ["shop_id"], name: "index_expenses_on_shop_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.date "date"
    t.integer "amount"
    t.bigint "account_id"
    t.bigint "receipts_type_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_receipts_on_account_id"
    t.index ["receipts_type_id"], name: "index_receipts_on_receipts_type_id"
  end

  create_table "receipts_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.date "date"
    t.integer "amount"
    t.bigint "account_id"
    t.integer "account_to_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transfers_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "accounts", "account_types"
  add_foreign_key "accounts", "banks"
  add_foreign_key "accounts", "currencies"
  add_foreign_key "accounts", "users"
  add_foreign_key "balances", "accounts"
  add_foreign_key "expense_plans", "expense_types"
  add_foreign_key "expense_rows", "expense_types"
  add_foreign_key "expense_rows", "expenses"
  add_foreign_key "expense_types", "expense_kinds"
  add_foreign_key "expenses", "accounts"
  add_foreign_key "expenses", "expense_types"
  add_foreign_key "expenses", "shops"
  add_foreign_key "expenses", "users"
  add_foreign_key "receipts", "accounts"
  add_foreign_key "receipts", "receipts_types"
  add_foreign_key "transfers", "accounts"
end
