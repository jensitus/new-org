class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, id: :uuid do |t|

      t.text :body
      t.uuid :user_id
      t.references :micropost, null: false, foreign_key: true, type: :uuid

      t.timestamps

    end
  end
end
