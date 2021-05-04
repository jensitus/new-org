class Photo < ApplicationRecord
  has_one_attached :image
  has_many :photo_microposts
  has_many :microposts, through: :photo_microposts
  # mount_uploader :picture, PictureUploader
end
