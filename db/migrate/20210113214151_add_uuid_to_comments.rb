class AddUuidToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    rename_column :comments, :id, :integer_id
    rename_column :comments, :uuid, :id
    execute 'ALTER TABLE comments drop constraint comments_pkey;'
    execute 'ALTER TABLE comments ADD PRIMARY KEY (id);'

    # Optinally you remove auto-incremented
    # default value for integer_id column
    execute 'ALTER TABLE ONLY comments ALTER COLUMN integer_id DROP DEFAULT;'
    change_column_null :comments, :integer_id, true
    execute 'DROP SEQUENCE IF EXISTS comments_id_seq'
  end
end
