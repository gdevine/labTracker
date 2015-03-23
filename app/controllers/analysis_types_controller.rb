class AnalysisTypesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @analysis_types = AnalysisType.all
  end
  
  def new
    if User.where(role:'technician').count == 0
      flash[:error] = "New Analysis Types cannot be added until at least one Technician is added to the system. Contact the admin to do this."
      redirect_to root_url
    else
      @analysis_type = AnalysisType.new
      @analysis_type.analysis_type_users.build
    end
  end
  
  def create
    @analysis_type = AnalysisType.new(analysis_type_params)
    if @analysis_type.save
      flash[:success] = "Analysis Type created!"
      redirect_to @analysis_type
    else
      @analysis_types = []
      render 'analysis_types/new'
    end
  end
  
  def show
    @analysis_type = AnalysisType.find(params[:id])
  end
  
  def edit
    # @analysis_type = AnalysisType.find(params[:id])
  end
  
  def update
    @analysis_type = AnalysisType.find(params[:id])
    if @analysis_type.update_attributes(analysis_type_params)
      flash[:success] = "Analysis Type Updated!"
      redirect_to @analysis_type
    else
      render 'edit'
    end
  end
  
  def destroy
    @analysis_type.destroy
    flash[:success] = "Analysis Type Deleted!"
    redirect_to analysis_types_path
  end
  
  private

    def analysis_type_params
      params.require(:analysis_type).permit(:name, :instrument, :description, :technician_ids=> [])
    end

end