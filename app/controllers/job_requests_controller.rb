class JobRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,  only: [:edit, :update, :destroy]
  
  def index
    @analysis_types = AnalysisType.all
  end
  
  def new
    if AnalysisType.count == 0
      flash[:error] = "New Job Requests cannot be created until at least one Analysis Type is added to the system. Contact the admin to do this."
      redirect_to root_url
    else
      @job_request = JobRequest.new
    end
  end
  
  def create
    @job_request = JobRequest.new(job_request_params)
    @job_request.researcher = current_user
    if @job_request.save
      flash[:success] = "Job Request created!"
      redirect_to @job_request
    else
      @job_requests = []
      render 'job_requests/new'
    end
  end
  
  def show
    @job_request = JobRequest.find(params[:id])
  end
  
  
  private

    def job_request_params
      params.require(:job_request).permit(:analysis_type_id, :project, :samples, :comments)
    end
    
    def correct_user
      @job_request = current_user.job_requests.find_by(id: params[:id])
      redirect_to root_url if @job_request.nil?
    end

  
end
