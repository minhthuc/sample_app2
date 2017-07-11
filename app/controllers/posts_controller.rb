class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user_post, only: :destroy
  before_action :load_post, only: [:show, :destroy]

  def index
    @posts = Post.all.sort_by_time.paginate page: params[:page], per_page:
    Settings.user.per_page_size
    @post = current_user.posts.build if logged_in?
  end

  def show
    @user = User.find_by id: @post.user_id
    @comment = Comment.new
    @comments = Post.find_by(id: params[:id]).comments.sort_by_time.
      paginate page: params[:page], per_page: 3
  end

  def destroy
    @post.destroy ? flash[:success] = t("post.controller.deleted") :
      flash[:danger] = t("post.controller.deleted_fail")
    redirect_to :back
  end
  
  def create
    @post = current_user.posts.build post_param
    @post.save ? flash[:success] = "Posted" :
      flash[:danger] = t("post.controller.wrong")
    redirect_to :back
  end


  private

  def load_post
    @post = Post.find_by id: params[:id]
  end

  def post_param
    params.require(:post).permit :body, :title
  end

  def correct_user_post
    current_user.id == load_post.user_id
  end
end
