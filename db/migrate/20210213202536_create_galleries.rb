class CreateGalleries < ActiveRecord::Migration[6.1]
  def change
    create_table :galleries, id: :uuid do |t|
      t.string :title
      t.text :description
      t.uuid :user_id

      t.timestamps
    end
  end
end
