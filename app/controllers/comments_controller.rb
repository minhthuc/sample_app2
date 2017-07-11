class CommentsController < ApplicationController
  before_action :load_comment, only: :destroy
  def show
    @comments = current_post.comments
  end

  def create
    @comment = current_user.comments.build comment_param
    @comment.save ? flash[:success] = t("comment.controller.commented") :
      flash[:danger] = t("comment.controller.comment_failure")
    redirect_to :back
  end

  def destroy
    @comment.destroy ? flash[:success] = t("post.controller.deleted") :
      flash[:danger] = t("post.controller.deleted_fail")
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
