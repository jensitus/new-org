class Posting < ApplicationRecord
  # t.string "title"
  # t.text "content"
  # t.uuid "user_id"
  # t.datetime "created_at", precision: 6, null: false
  # t.datetime "updated_at", precision: 6, null: false

  has_many :comments, dependent: :destroy

  validates_presence_of :title, :user_id
end
