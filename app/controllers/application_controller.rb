class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:edit, :create, :update, :new]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    # update時にも、編集できるようにカラムを追加する
    devise_parameter_sanitizer.permit(:acount_update, keys: [:nickname, :icon, :introduction, :URL])
  end

  def after_sign_in_path_for(resource)
    root_path
  end

end