class AddUniqueIndexToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, :unique => true
    add_index :users, :name, :unique => true
    add_index :ur_org_users, :email, :unique => true
    add_index :ur_org_users, :name, :unique => true
  end
end
