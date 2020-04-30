class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name).page(params[:page]).per(10).order(created_at: :DESC)
  end
end
