class AnalysisTypeUser < ActiveRecord::Base
  belongs_to :analysis_type, :class_name => 'AnalysisType', :foreign_key => 'analysis_type_id' 
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  
  accepts_nested_attributes_for :user
  
  validates_presence_of :analysis_type, :user
end
