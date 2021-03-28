class AddPostingIdToPhotoGallery < ActiveRecord::Migration[6.1]
  def change
    add_column :photo_galleries, :micropost_id, :uuid
  end
end
