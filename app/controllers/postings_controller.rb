class PostingsController < ApplicationController
  before_action :set_posting, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @postings = Posting.all
    json_response(@postings)
  end

  # POST /posts
  def create
    puts posting_params.inspect
    @posting = Posting.create!(posting_params)
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
    params.permit(:title, :content, :user_id)
  end

  def set_posting
    @posting = Posting.find(params[:id])
  end

end
