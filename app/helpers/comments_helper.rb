module CommentsHelper
  def load_user_name id
    User.find_by(id: id)
  end
end
