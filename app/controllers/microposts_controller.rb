class MicropostsController < ApplicationController
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
    @microposts.each do |p|
      posting_photos = []
      if p.photos.attached?
        p.photos.each do |photo|
          posting_photos.push(rails_blob_url(photo))
        end
      end
      posting = MicropostDto.new(p.id, p.title, p.content, p.user_id, p.created_at, p.updated_at, posting_photos)
      postings.push(posting)
    end
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
    posting_photos = []
    if @micropost.photos.attached?
      @micropost.photos.each do |photo|
        posting_photo = PhotoDto.new(photo.id, rails_blob_url(photo))
        posting_photos << posting_photo
      end
    end
    posting = MicropostDto.new(
        @micropost.id,
        @micropost.title,
        @micropost.content,
        @micropost.user_id,
        @micropost.created_at,
        @micropost.updated_at,
        posting_photos
    )
    json_response(posting, :ok)
  end

  def delete_photos
    @micropost.photos.find(params[:attachment_id]).purge
    json_response(@micropost, :ok)
  end

  # PUT /posts/:id
  def update
    @micropost.update(posting_params)
    head :no_content
  end

  def update_pic
    @micropost.photos.attach(params[:photo])
    json_response(@micropost, :ok)
  end

  # DELETE /posts/:id
  def destroy
    @micropost.destroy
    head :no_content
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

  def validate_user
    if @micropost.user_id != @current_user.id
      json_response(Message.no_permission, :forbidden)
    end
  end

end
