class PostingDto

  attr_accessor :id, :title, :content, :user_id, :created_at, :updated_at, :photos

  def initialize(id, title, content, user_id, created_at, updated_at, photos)
    @id = id
    @title = title
    @content = content
    @user_id = user_id
    @created_at = created_at
    @updated_at = updated_at
    @photos = photos
  end

end