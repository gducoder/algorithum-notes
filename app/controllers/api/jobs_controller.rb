class Api::JobsController < Api::ApplicationController
  before_action :authenticate_user!
  def index
    @jobs=Job.all
    render json: @jobs, status: 200
  end

  def new
    @job=Job.new()
  end

  def create
    @job = Job.new(job_params)
 

    if @job.save
    redirect_to jobs_path
    else
      render 'new'
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def destroy
  @job = Job.find(params[:id])

    @job.destroy

  redirect_to jobs_path

  end

  def close_job

    @job = Job.find(params[:job_id])
    @notification=Notification.find_by_job_id(@job.id)
    @user=User.find(@job.user_id)

    if @notification.present?
      @notification.destroy
    end

    if @job.update_columns(status: "Complete",user_id: nil ) && @user.update_columns(job_assigned: false )
      redirect_to @job
      end
  end

  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      redirect_to @job
    else
      render 'edit'
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def is_admin

    unless current_user.user_type =="Admin"
      redirect_to user_path(current_user.id)
    end

  end
  private
  def job_params
    params.require(:job).permit(:status,  :source_lat, :source_long, :destination_lat, :destination_long, :details, :user_id)
  end
end

