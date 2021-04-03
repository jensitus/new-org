class PhotoGallery < ApplicationRecord
  belongs_to :photo
  belongs_to :gallery
end
