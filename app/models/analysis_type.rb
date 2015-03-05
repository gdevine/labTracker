class AnalysisType < ActiveRecord::Base
  
  validates :name, :presence => { :message => "Name is required" }, length: { maximum: 80 }, uniqueness: { case_sensitive: false }
  validates :description, :presence => { :message => "A description is required" }

end
