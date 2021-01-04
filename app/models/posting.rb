class Posting < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates_presence_of :title, :user_id
end
