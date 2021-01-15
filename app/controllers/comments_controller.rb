class CommentsController < ApplicationController
  before_action :set_posting
  before_action :set_posting_comment, only: [:show, :update, :destroy]

  # GET /posts/:post_id/comments
  def index
    c = json_response(@posting.comments)
    puts c.inspect
    c
  end

  # GET /posts/:post_id/comments/:id
  def show
    json_response(@comment)
  end

  # POST /posts/:post_id/comments
  def create
    @posting.inspect
    @posting.comments.create!(body: comment_params[:body], posting_id: @posting.id, user_id: @current_user_id)
  end

  # PUT /posts/:post_id/comments/:id
  def update
    @comment.update(comment_params)
    head :no_content
  end

  # DELETE /posts/:post_id/comments/:id
  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.permit(:body)
  end

  def set_posting
    @posting = Posting.find(params[:posting_id])
  end

  def set_posting_comment
    @comment = @posting.comments.find_by!(id: params[:id]) if @posting
  end
end
