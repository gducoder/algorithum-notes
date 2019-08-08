class Api::JobsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :is_admin ,except: [:show]
  def index
    @jobs=Job.all
    render json: @jobs, status: 200
  end

  def show
    @job = Job.find(params[:id])
    if (@job.user_id != current_user.id && current_user.user_type != 'Admin')
      render :json => { :errors => "You cannot view other drivers job" }
    else
      render json: @job, status: 200
    end
  end

  def is_admin

    unless current_user.user_type =="Admin"
      render :json => { :errors => "Only Admin can access this information" }
    end

  end
  private
  def job_params
    params.require(:job).permit(:status,  :source_lat, :source_long, :destination_lat, :destination_long, :details, :user_id)
  end
end

