class AddImageToAvatar < ActiveRecord::Migration[6.1]
  def change
    add_column :avatars, :image, :string
  end
end
