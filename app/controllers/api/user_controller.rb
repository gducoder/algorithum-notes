class  Api::UserController < Api::ApplicationController
  before_action :is_admin ,only: [:index]
  def index
    @users = User.where(:user_type => "User")
    render json: @users, status: 200

  end

  def show
    @user = User.find(params[:id])
    if (@user.id != current_user.id && current_user.user_type != 'Admin')
      render :json => { :errors => "You cannot view other drivers profile" }
    else
      render json: @user, status: 200
    end
  end

  def is_admin

    unless current_user.user_type == "Admin"
      render :json => { :errors => "Only Admin can access this information" }
    end
  end
end
