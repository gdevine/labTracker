class AnalysisType < ActiveRecord::Base
  has_many :analysis_type_users, :dependent => :destroy, inverse_of: :analysis_type
  has_many :technicians, -> { order :surname }, :through => :analysis_type_users, source: :user
  has_many :job_requests, :class_name => 'JobRequest', :foreign_key => 'analysis_type_id', :dependent => :destroy

  accepts_nested_attributes_for :analysis_type_users
  
  before_save :require_at_least_one_technician
  
  validates :name, :presence => { :message => "Name is required" }, length: { maximum: 80 }, uniqueness: { case_sensitive: false }
  validates :description, :presence => { :message => "A description is required" }
  
  validate :only_technician_roles
  validate :require_at_least_one_technician
  
  
  private

  def only_technician_roles
    if !self.id.nil?
      self.technicians.each do |technician|
        if technician.role != 'technician'
          errors.add(:base, "Associated technicians must be of user role 'technician'")
          break
        end   
      end
    end
  end
  
  def require_at_least_one_technician
    errors.add(:base, "An Analysis Type must have at least one technician associated with it") if
      self.technicians.size == 0 
  end

end