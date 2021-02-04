class Posting < ApplicationRecord
  # t.string "title"
  # t.text "content"
  # t.uuid "user_id"
  # t.datetime "created_at", precision: 6, null: false
  # t.datetime "updated_at", precision: 6, null: false

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates_presence_of :title, :content, :user_id
end
