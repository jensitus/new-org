class AddSlugToUrOrgUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :ur_org_users, :slug, :string
    add_column :ur_org_users, :old_integer_id, :integer
    add_column :ur_org_users, :cookie, :boolean, default: false
  end
end
