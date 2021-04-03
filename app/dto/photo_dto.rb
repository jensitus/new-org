class PhotoDto

  attr_accessor :photo_id, :photo_url

  def initialize(photo_id, photo_url)
    @photo_id = photo_id
    @photo_url = photo_url
  end

end