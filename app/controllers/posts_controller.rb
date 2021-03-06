class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit]
  before_action :access_right_check, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:user, :tags).order(created_at: :DESC).page(params[:page]).per(10)
    @tags = ActsAsTaggableOn::Tag.most_used(15)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to root_path, notice: "投稿を作成しました"
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @tags = @post.tags
    @like = Like.new
    if user_signed_in? && current_user.already_liked?(@post)
      @like = Like.find_by(post_id: @post.id, user_id: current_user.id)
    end
  end

  def search
    @posts = Post.search(params[:keyword]).order(created_at: :DESC)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)

    if @post.save
      redirect_to post_path, notice: "投稿内容を編集しました"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path, notice: "投稿内容を削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:text, :image, :tag_list).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def access_right_check
    post = Post.find(params[:id])
    unless current_user.id == post.user_id
      redirect_to action: :index
      flash[:alert] = "権限がありません"
    end
  end

end
