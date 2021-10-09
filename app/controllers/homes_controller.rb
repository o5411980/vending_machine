class HomesController < ApplicationController
  def index
    @users = User.where(admin: true)
    @user = current_user
  end
end
