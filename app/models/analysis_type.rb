class AnalysisType < ActiveRecord::Base
  has_many :analysis_type_users, :dependent => :destroy, inverse_of: :analysis_type
  # has_many :technicians, :class_name => 'User', :through => :analysis_type_users, source: :user
  has_many :technicians, :through => :analysis_type_users, source: :user
  
  accepts_nested_attributes_for :analysis_type_users
  
  validates :name, :presence => { :message => "Name is required" }, length: { maximum: 80 }, uniqueness: { case_sensitive: false }
  validates :description, :presence => { :message => "A description is required" }

end