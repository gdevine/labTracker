class JobRequest < ActiveRecord::Base
  belongs_to :researcher, :class_name => 'User', :foreign_key => 'researcher_id'
  belongs_to :analysis_type, :class_name => 'AnalysisType', :foreign_key => 'analysis_type_id'
  
  validates :researcher_id, :presence => { :message => "A job request must belong to a researcher" }
  validates :researcher, :presence => { :message => "A job request must belong to a researcher" }
  validates :analysis_type_id, :presence => { :message => "A Job Request must be associated with an Analysis Type" }
  validates :analysis_type, :presence => { :message => "A Job Request must be associated with an Analysis Type" }
  validates :project, :presence => { :message => "A Project must be present" }
  
  validate :only_researcher_roles
  
  
  private

  def only_researcher_roles
    if !self.researcher.nil? && self.researcher.role != 'researcher'
      errors.add(:base, "Owning Researcher must be of user role 'researcher'")
    end
  end
end
