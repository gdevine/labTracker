class AnalysisTypesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @analysis_types = AnalysisType.all
  end
  
  def new
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
  
  private

    def analysis_type_params
      params.require(:analysis_type).permit(:name, :instrument, :description)
    end

end