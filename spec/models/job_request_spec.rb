require 'rails_helper'

RSpec.describe JobRequest, type: :model do
  before do 
    @job_request = FactoryGirl.create(:job_request) 
  end
  
  subject { @job_request }

  it { should respond_to(:researcher_id) }
  it { should respond_to(:researcher) }
  it { should respond_to(:analysis_type_id) }
  it { should respond_to(:analysis_type) }
  it { should respond_to(:samples) }
  it { should respond_to(:project) }
  it { should respond_to(:comments) }

  it { should be_valid }
  
  # Presence checks
  describe "when researcher id is not present" do
    before { @job_request.researcher_id = '' }
    it { should_not be_valid }
  end
  
  describe "when researcher is not present" do
    before { @job_request.researcher = nil }
    it { should_not be_valid }
  end
  
  describe "when analysis type is not present" do
    before { @job_request.analysis_type = nil }
    it { should_not be_valid }
  end  
  
  describe "when analysis type id is not present" do
    before { @job_request.analysis_type_id = "" }
    it { should_not be_valid }
  end  

  describe "when project is not present" do
    before { @job_request.project = " " }
    it { should_not be_valid }
  end
  
  describe "when comments are not present" do
    before { @job_request.comments = " " }
    it { should be_valid }
  end
  
  
  describe "technicians should not be able to be added as researchers" do  
    let!(:technician) {FactoryGirl.create(:technician)}
    
    before do 
      @job_request.researcher = technician
    end
    
    it { should_not be_valid } 
    
  end  
  
  describe "superusers should not be able to be added as researchers" do  
    let!(:superuser) {FactoryGirl.create(:superuser)}
    
    before do 
      @job_request.researcher = superuser
    end
    
    it { should_not be_valid } 
  end  

  describe "when researcher does not exist" do
    before { @job_request.researcher_id = 10000 }
    it { should_not be_valid }
  end  

  describe "when analysis type does not exist" do
    before { @job_request.analysis_type_id = 10000 }
    it { should_not be_valid }
  end  
  
end