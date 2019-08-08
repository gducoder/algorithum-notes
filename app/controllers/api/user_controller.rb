class UserController < ApplicationController
  before_action :is_admin ,only: [:index]
  def index
    @users = User.where(:user_type => "User")
    render json: @users, status: 200
  end

  def show
    @user = User.find(params[:id])
    render json: @users
  end

  def is_admin

    unless current_user.user_type =="Admin"
      redirect_to user_path(current_user.id)
    end

  end

end
