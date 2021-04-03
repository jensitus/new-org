class Micropost < ApplicationRecord
  # t.string "title"
  # t.text "content"
  # t.uuid "user_id"
  # t.datetime "created_at", precision: 6, null: false
  # t.datetime "updated_at", precision: 6, null: false

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :photo_microposts
  has_many :photos, through: :photo_microposts

  validates_presence_of :title, :content, :user_id

  def self.paginated(limit = 5, offset = 0)
    Micropost.order(updated_at: :desc).limit(limit).offset(offset)
  end

end
