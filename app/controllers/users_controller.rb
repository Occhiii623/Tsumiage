class UsersController < ApplicationController

  def show
    # 該当ユーザーのデータを取得
    user = User.find(params[:id])
    @icon = user.icon
    @nickname = user.nickname
    # ビューに必要なインスタンス変数を定義
    if user[:introduction].nil?
      @introduction = "※プロフィール文はまだ設定されていません"
    else
      @introduction = user.introduction
    end

    if user[:URL].nil?
      @URL = "※URLはまだ設定されていません"
    else
      @URL = user.URL
    end
  end


end
