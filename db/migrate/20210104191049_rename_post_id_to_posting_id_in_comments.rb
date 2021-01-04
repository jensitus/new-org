class RenamePostIdToPostingIdInComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :post_id, :posting_id
  end
end
