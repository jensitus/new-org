class PhotoDto

  attr_accessor :attachment_id, :photo_url

  def initialize(attachment_id, photo_url)
    @attachment_id = attachment_id
    @photo_url = photo_url
  end

end