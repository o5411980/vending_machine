class UsersController < ApplicationController

  def show
    @user = current_user
#    @user = User.find(params[:id])
  end

  def update
  #Ajacsで管理者メッセージ更新。
  @users = User.where(admin: true)
  @user = current_user
  @user.update(admin_message: homes_params)
  end

  private
  def homes_params
    params.require(:user).permit(:admin_message)
  end
end
