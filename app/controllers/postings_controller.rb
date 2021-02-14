class PostingsController < ApplicationController
  before_action :set_posting, only: [:show, :update, :destroy, :update_pic]

  # GET /posts
  def index
    @postings = Posting.all
    json_response(@postings)
  end

  # POST /posts
  def create
    posting = Posting.create!(title: posting_params[:title], content: posting_params[:content], user_id: @current_user.id)
    json_response(posting, :created)
  end

  # GET /posts/:id
  def show
    posting_photos = []
    if @posting.photos.attached?
      @posting.photos.each do |photo|
        posting_photos << rails_blob_url(photo)
      end
    end
    posting = {
        id: @posting.id,
        title: @posting.title,
        content: @posting.content,
        user_id: @posting.user_id,
        photos: posting_photos
    }
    puts @posting.inspect
    json_response(posting, :ok)
  end

  # PUT /posts/:id
  def update
    @posting.update(posting_params)
    head :no_content
  end

  def update_pic
    puts '##############################'
    @posting.photos.attach(params[:photo])
    json_response(@posting, :ok)
  end

  # DELETE /posts/:id
  def destroy
    @posting.destroy
    head :no_content
  end


  private

  def posting_params
    params.require(:posting).permit(:title, :content, :user_id)
  end

  def set_posting
    @posting = Posting.find(params[:id])
  end

  def photo_params
    params.require(:posting).permit(photos: [])
  end

end
