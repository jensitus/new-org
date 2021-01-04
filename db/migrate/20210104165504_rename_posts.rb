class RenamePosts < ActiveRecord::Migration[6.1]
  def change
    rename_table :postings, :postings
  end
end
