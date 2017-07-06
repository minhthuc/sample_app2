class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate page: params[:page],
      per_page: Settings.user.per_page_size
  end

  def show
    render template: "static_pages/#{params[:page]}"
  end
end
