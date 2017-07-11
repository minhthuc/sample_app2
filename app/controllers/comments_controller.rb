class CommentsController < ApplicationController
  before_action :load_comment, only: :destroy
  def show
    @comments = current_post.comments
  end

  def create
    @comment = current_user.comments.build comment_param
    @comment.save ? flash[:success] = "Commented" :
      flash[:danger] = "Not comment yet"
    redirect_to :back
  end

  def destroy
    @comment.destroy ? flash[:success] = "Deleted" :
      flash[:danger] = "Not Deleted"
    redirect_to :back
  end

  private

  def comment_param
    params.require(:comment).permit :content, :post_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end
end
