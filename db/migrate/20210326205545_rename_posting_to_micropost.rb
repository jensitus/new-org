class RenamePostingToMicropost < ActiveRecord::Migration[6.1]
  def change
    rename_table :postings, :microposts
    rename_column :comments, :micropost_id, :micropost_id
    rename_column :photo_galleries, :micropost_id, :micropost_id
  end
end
