class AnalysisType < ActiveRecord::Base
  
  validates :name, presence: true, length: { maximum: 80 }
  validates :description, presence: true

end
