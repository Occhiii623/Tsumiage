class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).order(created_at: :DESC)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:notice] = '投稿を作成しました'
      redirect_to root_path
    else
      render :new
    end
  end


  private
  def post_params
    params.require(:post).permit(:text, :image).merge(user_id: current_user.id)
  end

end
