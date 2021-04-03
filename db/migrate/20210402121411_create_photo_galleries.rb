class CreatePhotoGalleries < ActiveRecord::Migration[6.1]
  def change
    rename_table :photo_galleries, :galleries
    create_table :photo_galleries, id: :uuid do |t|
      t.references :photo, null: false, foreign_key: true, type: :uuid
      t.references :gallery, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
