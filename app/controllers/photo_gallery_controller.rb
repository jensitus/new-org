class PhotoGalleryController < ApplicationController
  before_action :set_gallery, only: [:show, :update, :delete, :update_pics]

  def index
  end

  def show
    gallery_photos = []
    if @gallery.photos.attached?
      @gallery.photos.each do |photo|
        gallery_photos.push(rails_blob_url(photo))
      end
    end
    gallery = {
        id: @gallery.id,
        title: @gallery.title,
        description: @gallery.description,
        user_id: @gallery.user_id,
        photos: gallery_photos
    }
    json_response(gallery, :ok)
  end

  def create
    puts gallery_params.inspect
    gallery = PhotoGallery.create!(title: gallery_params[:title], description: gallery_params[:description], user_id: @current_user.id)
    json_response(gallery, :created)
  end

  def update
  end

  def update_pics
    @gallery.photos.attach(gallery_params[:photo])
    json_response(@gallery, :ok)
  end

  def delete
  end

  private

  def set_gallery
    @gallery = PhotoGallery.find(params[:id])
  end

  def gallery_params
    params.permit(:title, :description, :photo)
  end

end
