class ChangePostingIdInComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :p_id, :uuid
    rename_column :comments, :posting_id, :posting_integer_id
    rename_column :comments, :p_id, :posting_id
  end
end
