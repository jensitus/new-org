class AddResentAtToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :reset_sent_at, :datetime
    add_column :users, :reset_digest, :string
  end
end
