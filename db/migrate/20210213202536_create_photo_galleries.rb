class CreatePhotoGalleries < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_galleries, id: :uuid do |t|
      t.string :title
      t.text :description
      t.uuid :user_id

      t.timestamps
    end
  end
end
