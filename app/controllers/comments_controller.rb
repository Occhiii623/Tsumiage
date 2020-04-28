class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
      respond_to do |format|
        format.html { redirect_to post_path(comment.post.id) }
        format.json
      end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(comment.post.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end