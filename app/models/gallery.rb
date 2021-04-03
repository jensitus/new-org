class Gallery < ApplicationRecord
  has_many :photo_galleries
  has_many :photos, through: :photo_galleries
end
