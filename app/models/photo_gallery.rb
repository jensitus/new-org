class PhotoGallery < ApplicationRecord
  has_many_attached :photo
end
