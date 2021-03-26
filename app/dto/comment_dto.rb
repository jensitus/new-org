class CommentDto

  attr_accessor :body, :username, :user_id, :posting_id, :created_at, :updated_at

  def initialize(body, username, user_id, posting_id, created_at, updated_at)
    @body = body
    @username = username
    @user_id = user_id
    @posting_id = posting_id
    @created_at = created_at
    @updated_at = updated_at
  end

end