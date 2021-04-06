module GalleryModule

  def getGalleryDto(gallery)
    gallery_photos = []
    gallery.photos.each do |p|
      if p.image.attached?
        puts '# # # # # # # # # # # # # # # # # # # # # # # # #'
        puts p.image.variant(resize: "100x 100")
        puts '# # # # # # # # # # # # # # # # # # # # # # # # #'
        gallery_photo = PhotoDto.new(p.id, rails_blob_url(p.image))
        gallery_photos.push(gallery_photo)
      end
    end
    GalleryDto.new(gallery.id, gallery.title, gallery.description, gallery.user_id, gallery_photos)
  end

end