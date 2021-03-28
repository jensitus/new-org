class Comment < ApplicationRecord

  # t.text "body"
  # t.integer "user_id"
  # t.integer "posting_id", null: false
  # t.datetime "created_at", precision: 6, null: false
  # t.datetime "updated_at", precision: 6, null: false
  # t.index ["posting_id"], name: "index_comments_on_posting_id"

  belongs_to :micropost

  validates_presence_of :body
end
