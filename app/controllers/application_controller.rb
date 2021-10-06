class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user! #ログイン済のみアクセス可とする
  before_action :configure_permitted_parameters, if: :devise_controller? #deviseコントローラーにストロングパラメータを追加

  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) #サインアップ時にnameのストロングパラメータ追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :admin, :mr_ms, :employee_number, :icon, :comment]) #アカウント編集時にname他をストロングパラメータ追加
  end

end
