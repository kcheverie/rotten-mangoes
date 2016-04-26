class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    render text: 'An admin is you'
  end


end