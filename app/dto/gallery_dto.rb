class GalleryDto

  attr_accessor :id, :title, :description, :user_id, :photos

  def initialize(id, title, description, user_id, photos)
    @id = id
    @title = title
    @description = description
    @user_id = user_id
    @photos = photos
  end

end