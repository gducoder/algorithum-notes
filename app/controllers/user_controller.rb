class UserController < ApplicationController
  before_action :is_admin ,only: [:index]
  def index
    @users = User.where(:user_type => "User")
  end

  def show
    @user = User.find(params[:id])
    if (@user.id != current_user.id && current_user.user_type != 'Admin')
      redirect_back(fallback_location: root_path)
    end
  end

  def is_admin

    unless current_user.user_type =="Admin"
      redirect_to user_path(current_user.id)
    end

  end

end
