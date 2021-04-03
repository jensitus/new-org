module MicropostModule

  def getMicropostDto(micropost)
    posting_photos = []
    micropost.photos.each do |p|
      puts '++++ p.image.attached? +++++++'
      puts p.image.attached?
      if p.image.attached?
        photo = PhotoDto.new(p.id, rails_blob_url(p.image))
        posting_photos.push(photo)
      end
    end
    MicropostDto.new(
            micropost.id,
            micropost.title,
            micropost.content,
            micropost.user_id,
            micropost.created_at,
            micropost.updated_at,
            posting_photos
        )
  end

end