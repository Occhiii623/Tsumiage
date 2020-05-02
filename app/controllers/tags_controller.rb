class TagsController < ApplicationController
  def index
    return nil if params[:keyword] == ""
    @tags = ActsAsTaggableOn::Tag.where(['name LIKE ?', "%#{params[:keyword]}%"]).limit(5)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name).page(params[:page]).per(10).order(created_at: :DESC)
  end
end
