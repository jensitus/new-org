class MicropostsController < ApplicationController
  include MicropostModule
  before_action :set_micropost, only: [:show, :update, :destroy, :update_pic, :delete_photos]
  before_action :validate_user, only: [:destroy, :update, :update_pic]

  # GET /posts
  def index
    count = Micropost.all.count
    if params[:limit] == 'undefined' && params[:offset] === 'undefined'
      @microposts = Micropost.order(updated_at: :desc)
    else
      @microposts = Micropost.paginated(params[:limit], params[:offset])
    end
    postings = []
    @microposts.each do |m|
      posting_photos = []
      m.photos.each do |p|
        if p.image.attached?
          photo = PhotoDto.new(p.id, rails_blob_url(p.image))
          posting_photos.push(photo)
        end
      end
      posting = MicropostDto.new(m.id, m.title, m.content, m.user_id, m.created_at, m.updated_at, posting_photos)
      postings.push(posting)
    end
    # postings = get_micropost_dto_array
    posting_hash = {count: count, microposts: postings}
    json_response(posting_hash, :ok)
  end

  # POST /posts
  def create
    posting = Micropost.create!(title: posting_params[:title], content: posting_params[:content], user_id: @current_user.id)
    json_response(posting, :created)
  end

  # GET /posts/:id
  def show
    # postingDto = getMicropostDto(@micropost)
    json_response(getMicropostDto(@micropost), :ok)
  end

  def delete_photos
    @micropost.photos.each do |p|
      if p.image.attached? && p.id.eql?(params[:photo_id])
        p.image.purge
        @micropost.photos.delete(p)
        p.delete
      end
    end
    json_response(@micropost, :ok)
  end

  # PUT /posts/:id
  def update
    @micropost.update(posting_params)
    head :no_content
  end

  def update_pic
    photo = @micropost.photos.create!
    photo.image.attach(params[:image])
    # @micropost.photos.attach(params[:photo])
    json_response(@micropost, :ok)
  end

  # DELETE /posts/:id
  def destroy
    @micropost.destroy
    head :no_content
  end

  def by_user
    microposts = Micropost.where(user_id: user_params[:user_id]).order(created_at: :desc)
    postings = []
    microposts.each do |m|
      posting_photos = []
      m.photos.each do |p|
        if p.image.attached?
          photo = PhotoDto.new(p.id, rails_blob_url(p.image))
          posting_photos.push(photo)
        end
      end
      posting = MicropostDto.new(m.id, m.title, m.content, m.user_id, m.created_at, m.updated_at, posting_photos)
      postings.push(posting)
    end
    json_response(postings, :ok)
  end

  private

  def posting_params
    params.require(:micropost).permit(:title, :content, :user_id)
  end

  def set_micropost
    @micropost = Micropost.find(params[:id])
  end

  def photo_params
    params.require(:micropost).permit(photos: [])
  end

  def user_params
    params.permit(:user_id)
  end

  def validate_user
    if @micropost.user_id != @current_user.id
      json_response(Message.no_permission, :forbidden)
    end
  end

end
