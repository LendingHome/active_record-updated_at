ActiveRecord::Schema.define(version: 20161012223251) do
  create_table "users", force: :cascade do |t|
    t.string "name", index: true, null: false
    t.timestamps null: false, limit: 6
  end
end
