class CreateIndexOnPostings < ActiveRecord::Migration[6.1]
  def change
    add_index :microposts, :updated_at
  end
end
