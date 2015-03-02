class AnalysisType < ActiveRecord::Base
  
  validates :name, presence: true, length: { maximum: 80 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true

end
