class ChangeUserIdInComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :u_id, :uuid
    rename_column :comments, :user_id, :user_integer_id
    rename_column :comments, :u_id, :user_id
  end
end
