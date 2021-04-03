class CreatePhotoMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_microposts, id: :uuid do |t|
      t.references :photo, null: false, foreign_key: true, type: :uuid
      t.references :micropost, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
