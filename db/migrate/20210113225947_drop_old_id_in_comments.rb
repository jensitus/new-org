class DropOldIdInComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :posting_integer_id
    remove_column :comments, :user_integer_id
  end
end
