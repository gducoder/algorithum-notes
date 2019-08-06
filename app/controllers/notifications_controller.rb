class NotificationsController < ApplicationController
  def index
  @notifications=Notification.where(:user_id => current_user.id )
  end

  # def destroy
  #   @notification = Notification.find(params[:id])
  #
  #   @notification.destroy
  #
  #
  #
  # end
end
