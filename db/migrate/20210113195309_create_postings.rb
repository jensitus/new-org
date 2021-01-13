class CreatePostings < ActiveRecord::Migration[6.1]
  def change
    create_table :postings, id: :uuid do |t|
      t.string :title
      t.text :content
      t.uuid :user_id

      t.timestamps
    end
  end
end
