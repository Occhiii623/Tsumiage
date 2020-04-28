class UsersController < ApplicationController

  def show
    # 該当ユーザーのデータを取得
    user = User.find(params[:id])
    @posts = user.posts.order(created_at: :DESC).page(params[:page]).per(10)
    
    @icon = user.icon
    @nickname = user.nickname
    @URL = user.URL
    # ビューに必要なインスタンス変数を定義
    if user[:introduction].nil?
      @introduction = "※プロフィール文はまだ設定されていません"
    else
      @introduction = user.introduction
    end
  end
end
