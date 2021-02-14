class PhotoGalleryController < ApplicationController
  before_action :set_gallery, only: [:show, :update, :delete]

  def index
  end

  def show
  end

  def create
    gallery = PhotoGallery.create!(title: gallery_params[:title], description: gallery_params[:description])
    gallery.photo.attach(gallery_params[:photo])
  end

  def update
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
