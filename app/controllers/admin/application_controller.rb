class Admin::ApplicationController < ApplicationController

  before_filter :check_admin

  private

  def check_admin
    if (current_user && !current_user.admin) || !current_user 
      flash[:alert] = "Access is restricted"
      redirect_to root_path
    end
  end

end
