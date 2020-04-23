class UsersController < ApplicationController

  def show
    # 該当ユーザーのデータを取得
    @user = User.find(params[:id])
    # ビューに必要なインスタンス変数を定義

  end
end
