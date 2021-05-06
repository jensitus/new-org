module CommentModule

  def return_comment_list(comments)
    commentDtoList = Array.new
    comments.each do |c|
      user = User.find_by(id: c.user_id)
      commentDtoList << CommentDto.new(c.body, user.name, c.user_id, c.micropost_id, c.created_at, c.updated_at)
    end
    commentDtoList
  end

end