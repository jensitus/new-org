class PhotoGallery < ApplicationRecord
  has_many_attached :photos
end
