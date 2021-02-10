class PostingsController < ApplicationController
  before_action :set_posting, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @postings = Posting.all
    json_response(@postings)
  end

  # POST /posts
  def create
    @posting = Posting.create!(title: posting_params[:title], content: posting_params[:content], user_id: @current_user.id)
    json_response(@posting, :created)
  end

  # GET /posts/:id
  def show
    json_response(@posting)
  end

  # PUT /posts/:id
  def update
    @posting.update(posting_params)
    head :no_content
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

end
