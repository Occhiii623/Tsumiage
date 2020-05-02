class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  def index
    # 今ログインしている人のユーザー情報を取得
    @user = current_user
    @users = @user.followings
    @posts = []
    if @users.present?
      @users.each do |user|
      posts = Post.where(user_id: user.id).order(created_at: :DESC)
      @posts.concat(posts)
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
      end
    end
  end

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:notice] = 'ユーザーをフォローしました'
      redirect_to @user
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to @user
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:notice] = 'ユーザーのフォローを解除しました'
      redirect_to @user
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to @user
    end
  end

  private
  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end

end