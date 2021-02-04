class CreateUrOrgUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :ur_org_users, id: :uuid do |t|
      t.uuid :user_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
