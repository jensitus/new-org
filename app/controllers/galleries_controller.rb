class GalleriesController < ApplicationController
  include GalleryModule
  before_action :set_gallery, only: [:show, :update, :delete, :update_pics]
  before_action :update_permission, only: [:update, :delete, :update_pics]

  def index
    galleries = Gallery.where(user_id: params[:user_id])
    json_response(galleries, :ok)
  end

  def show
    gallery = getGalleryDto(@gallery)
    json_response(gallery, :ok)
  end

  def create
    gallery = Gallery.create!(title: gallery_params[:title], description: gallery_params[:description], user_id: @current_user.id)
    json_response(gallery, :created)
  end

  def update
    @gallery.update(gallery_params)
    json_response(getGalleryDto(@gallery), :ok)
  end

  def update_pics
    puts '* * * * * * * * * update pics * * * * *  * * * * *'
    puts params[:image]
    puts '* * * * * * * * * // update pics * * * * *  * * * * *'
    photo = @gallery.photos.create!
    photo.image.attach(params[:image])
    json_response(getGalleryDto(@gallery), :ok)
  end

  def delete
    @gallery.photos.each do |p|
      if p.image.attached? && p.id.eql?(params[:photo_id])
        p.image.purge
        @gallery.photos.delete(p)
        p.destroy
      end
    end
    json_response(getGalleryDto(@gallery), :ok)
  end

  private

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
    params.permit(:title, :description, :photo)
  end

  def update_permission
    if @gallery.user_id != @current_user.id
      json_response(Message.no_permission, :forbidden)
    end
  end

end
