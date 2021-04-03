class PhotoMicropost < ApplicationRecord
  belongs_to :photo
  belongs_to :micropost
end
