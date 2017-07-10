module UsersHelper
  def gravatar_for user, options = {size: Settings.user.option_size}
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def want_unfollow user, id
    @unfollow = user.active_relationships.find_by followed_id: id
  end

  def want_follow user
    @follower = user.active_relationships.build
  end
end
