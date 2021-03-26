module CommentModule

  def return_comment_list(comments)
    commentDtoList = Array.new
    comments.each do |c|
      ur_org_user = UrOrgUser.find_by_user_id(c.user_id)
      commentDtoList << CommentDto.new(c.body, ur_org_user.name, c.user_id, c.posting_id, c.created_at, c.updated_at)
    end
    commentDtoList
  end

end