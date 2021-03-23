class PhotoGalleryController < ApplicationController
  before_action :set_gallery, only: [:show, :update, :delete, :update_pics]
  before_action :update_permission, only: [:update, :delete, :update_pics]

  def index
    galleries = PhotoGallery.where(user_id: params[:user_id])
    json_response(galleries, :ok)
  end

  def show
    gallery_photos = []
    if @gallery.photos.attached?
      @gallery.photos.each do |photo|
        gallery_photo = PhotoDto.new(photo.id, rails_blob_url(photo))
        gallery_photos.push(gallery_photo)
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
    @gallery.update(gallery_params)
    json_response(@gallery, :ok)
  end

  def update_pics
    @gallery.photos.attach(gallery_params[:photo])
    json_response(@gallery, :ok)
  end

  def delete
    @gallery.photos.find(params[:attachment_id]).purge
    json_response(@gallery, :ok)
  end

  private

  def set_gallery
    @gallery = PhotoGallery.find(params[:id])
  end

  def gallery_params
    params.permit(:title, :description, :photo)
  end

  def update_params
    params.permit()
  end

  def update_permission
    if @gallery.user_id != @current_user.id
      json_response(Message.no_permission, :forbidden)
    end
  end

end
