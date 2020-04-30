class UsersController < ApplicationController

  def show

    user = User.find(params[:id])
    @posts = user.posts.order(created_at: :DESC).page(params[:page]).per(10)
    
    @icon = user.icon
    @nickname = user.nickname
    @URL = user.URL

    if user[:introduction].nil?
      @introduction = "※プロフィール文はまだ設定されていません"
    else
      @introduction = user.introduction
    end
  end
end