class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
    @users = @users.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.delete_email(@user).deliver
    @user.destroy
    redirect_to admin_users_path
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end