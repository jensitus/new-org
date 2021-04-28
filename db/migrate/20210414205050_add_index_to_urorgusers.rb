class AddIndexToUrorgusers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :ur_org_users, :user_id, false
  end
end
