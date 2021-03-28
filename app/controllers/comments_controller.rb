class CommentsController < ApplicationController
  include CommentModule
  before_action :set_micropost
  before_action :set_micropost_comment, only: [:show, :update, :destroy]

  # GET /posts/:post_id/comments
  def index
    json_response(return_comment_list(@micropost.comments))
  end

  # GET /posts/:post_id/comments/:id
  def show
    json_response(@comment)
  end

  # POST /posts/:post_id/comments
  def create
    puts '   +  +  +  +    comment_params: + +  +  +   +   +  +'
    puts comment_params.inspect
    puts @micropost.inspect
    puts @current_user.inspect
    @micropost.comments.create!(body: comment_params[:body], micropost_id: @micropost.id, user_id: @current_user.id)
    json_response(@micropost, :created)
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
    params.permit(:body, :user_id, :micropost_id)
  end

  def set_micropost
    puts params.inspect
    @micropost = Micropost.find(params[:micropost_id])
  end

  def set_micropost_comment
    puts ' +   +   +  +  +  params  *  *  *  *  *'
    puts params.inspect
    @comment = @micropost.comments.find_by!(id: params[:id]) if @micropost
  end
end
