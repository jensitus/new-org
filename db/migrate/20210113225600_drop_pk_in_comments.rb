class DropPkInComments < ActiveRecord::Migration[6.1]
  def change
    execute 'ALTER TABLE comments drop constraint comments_pkey;'
    execute 'ALTER TABLE comments ADD PRIMARY KEY (id);'
  end
end
