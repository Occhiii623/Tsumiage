class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]
  before_action :move_to_index

  def index
    # 今ログインしている人のユーザー情報を取得
    @users = current_user.followings
    @posts = []
    if @users.present?
      @users.each do |user|
      posts = Post.where(user_id: user.id)
      @posts.concat(posts)
      end
      @posts.sort! { |a,b| b.created_at <=> a.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
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

  def move_to_index
    unless user_signed_in?
      redirect_to root_path
      flash[:alert] = "権限がありません"
    end
  end

end