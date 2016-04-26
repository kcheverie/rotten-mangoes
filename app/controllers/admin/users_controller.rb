class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
    @users = @users.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

end