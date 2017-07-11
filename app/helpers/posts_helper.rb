module PostsHelper
  included UsersHelper
  def load_user id
    User.find_by id: id
  end

  def comment_size post
    post.comments.size
  end

  def comment_in
    @comment_in = current_post.comments.sort_by_time.paginate page: params[:id],
      per_page: 3
  end
end
