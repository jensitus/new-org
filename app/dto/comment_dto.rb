class CommentDto

  attr_accessor :body, :username, :user_id, :micropost_id, :created_at, :updated_at

  def initialize(body, username, user_id, micropost_id, created_at, updated_at)
    @body = body
    @username = username
    @user_id = user_id
    @micropost_id = micropost_id
    @created_at = created_at
    @updated_at = updated_at
  end

end