class LikesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:index]

  def index
    @posts = current_user.liked_posts.order(created_at: :DESC)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
  end

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

end
