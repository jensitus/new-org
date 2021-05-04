class AddPictureToPhoto < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :picture, :string
  end
end
