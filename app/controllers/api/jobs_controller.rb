class Api::JobsController < Api::ApplicationController
  before_action :authenticate_user!
  #before_action :is_admin ,except: [:show]
  def index
    if current_user.user_type == "Admin"
      if params[:job_id]
        @job = Job.find(params[:job_id])
      else
        @job = Job.all
      end
    else
      @job = Job.where(:user_id => current_user.id).first
    end
    render json: @job, status: 200
  end

  def show()
    @job = Job.find(params[:id])
    if (@job.user_id != current_user.id && current_user.user_type != 'Admin')
      render :json => { :errors => "You cannot view other drivers job" }
    else
      render json: @job, status: 200
    end
  end

  def accept_job
    @job = Job.where(:user_id => current_user.id).first
    if @job.present?
      if @job.status == "Pending"
        if @job.update_columns(status: "Accepted")
          render json: @job, status: 200
        end
      else
        render :json => { :errors => "You cannot perform this action" }
      end
    else
      render :json => { :errors => "No job has been assigned to you" }
    end
  end

  def reject_job
    @user=User.find(current_user.id)
    @job = Job.where(:user_id => current_user.id).first
    if @job.present?
      if @job.status == "Pending"
        if @job.update_columns(user_id: nil ) && @user.update_columns(job_assigned: false )
          render :json => { :status => "Job Rejected" }
        end
      else
        render :json => { :errors => "You cannot perform this action" }
      end
    else
      render :json => { :errors => "No job has been assigned to you" }
    end
  end

  def close_job
    @job = Job.where(:user_id => current_user.id).first
    @user=User.find(current_user.id)
    if @job.present?
      if @job.status == "Accepted"
        if @job.update_columns(status: "Complete",user_id: nil ) && @user.update_columns(job_assigned: false )
          render :json => { :status => "Job Completed" }
        end
      else
        render :json => { :errors => "You cannot perform this action" }
      end
    else
      render :json => { :errors => "No job has been assigned to you" }
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

