class RenamePostingToMicropost < ActiveRecord::Migration[6.1]
  def change
    rename_table :postings, :microposts
    rename_column :comments, :posting_id, :micropost_id
    rename_column :photo_galleries, :posting_id, :micropost_id
  end
end
