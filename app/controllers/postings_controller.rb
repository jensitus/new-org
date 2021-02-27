class PostingsController < ApplicationController
  before_action :set_posting, only: [:show, :update, :destroy, :update_pic]
  before_action :validate_user, only: [:destroy, :update, :update_pic]

  # GET /posts
  def index
    count = Posting.all.count
    if params[:limit] == 'undefined' && params[:offset] === 'undefined'
      @postings = Posting.order(updated_at: :desc)
    else
      @postings = Posting.paginated(params[:limit], params[:offset])
    end
    postings = []
    posting_hash = Hash.new
    @postings.each do |p|
      posting_photos = []
      if p.photos.attached?
        p.photos.each do |photo|
          posting_photos.push(rails_blob_url(photo))
        end
      end
      posting = PostingDto.new(p.id, p.title, p.content, p.user_id, p.created_at, p.updated_at, posting_photos)
      postings.push(posting)
    end
    posting_hash = {count: count, postings: postings}
    json_response(posting_hash, :ok)
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
    posting = PostingDto.new(
        @posting.id,
        @posting.title,
        @posting.content,
        @posting.user_id,
        @posting.created_at,
        @posting.updated_at,
        posting_photos
    )
    puts @posting.inspect
    json_response(posting, :ok)
  end

  # PUT /posts/:id
  def update
    @posting.update(posting_params)
    head :no_content
  end

  def update_pic
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

  def validate_user
    if @posting.user_id != @current_user.id
      json_response(Message.no_permission, :forbidden)
    end
  end

end
