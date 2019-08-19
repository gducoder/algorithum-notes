class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin ,except: [:show, :accept_job,:reject_job]

  def accept_job
    @notification=Notification.find(params[:notification_id])
    @job = Job.find(params[:job_id])
    if @job.update_columns(status: "Accepted")
      @notification.destroy
      redirect_to @job
    end
  end

  def reject_job
    @user=User.find(current_user.id)
    @notification=Notification.find(params[:notification_id])
    @job = Job.find(params[:job_id])
    if @job.update_columns(status: "Pending",user_id: nil ) && @user.update_columns(job_assigned: false )
      @notification.destroy
      redirect_to @job
    end
  end

  def assignjob
    @job = Job.find(params[:job_id])
    @users = User.where(:user_type => "User",:job_assigned => false)
    if @job.user_id != nil
      redirect_to root_path
    end
  end

  def assign_job_update
    @user=User.find(params[:job][:user_id])

    @job = Job.find(params[:job_id])
    @job.status = "Pending"
    if @job.update(job_params) && @user.update_columns(job_assigned: true )
      redirect_to @job
    else
      render 'jobs/assignjob'

    end

    @notification =Notification.new(user_id: params[:job][:user_id],job_id: params[:job_id])
    @notification.save
  end

  def index
    @jobs=Job.paginate(page: params[:page], per_page: 5)
      #binding.pry
    # render json: @jobs, status: 200,adapter: :json
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
    if (@job.user_id != current_user.id && current_user.user_type != 'Admin')
      redirect_back(fallback_location: root_path)
    end
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

