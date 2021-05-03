class CreateAvatars < ActiveRecord::Migration[6.1]
  def change
    create_table :avatars, id: :uuid do |t|

      t.string :user_id
      t.timestamps
    end
  end
end
