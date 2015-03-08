require 'rails_helper'

RSpec.describe AnalysisType, type: :model do
  before { @analysis_type = FactoryGirl.build(:analysis_type) }
  subject { @analysis_type }

  it { should respond_to(:name) }
  it { should respond_to(:instrument) }
  it { should respond_to(:description) }
  it { should respond_to(:technicians) }

  it { should be_valid }
  
  # Presence checks
  describe "when name is not present" do
    before { @analysis_type.name = " " }
    it { should_not be_valid }
  end
  
  describe "when description is not present" do
    before { @analysis_type.description = " " }
    it { should_not be_valid }
  end
  
  #Length checks
  describe "when name is too long" do
    before { @analysis_type.name = "a" * 81 }
    it { should_not be_valid }
  end
  
  #Uniqueness checks
  describe "when analysis type name is not unique" do    
    before do
      at_same_name = @analysis_type.dup
      at_same_name.save
    end
    
    it { should_not be_valid } 
  end
  
  
  describe "technician associations" do  
    let!(:technician_c) {FactoryGirl.create(:technician, surname: 'clarke')}
    let!(:technician_a) {FactoryGirl.create(:technician, surname: 'abbot')}
    let!(:technician_b) {FactoryGirl.create(:technician, surname: 'brown')}
    
    before do 
      @analysis_type.save
      @analysis_type.technicians << technician_b
      @analysis_type.technicians << technician_c
      @analysis_type.technicians << technician_a
    end
       
    it "should have associated technicians in alphabetical surname order" do
      expect(@analysis_type.technicians.to_a).to eq [technician_a, technician_b, technician_c]
    end
    
  end
  
  
  # describe "only technicians should be able to be added as users" do  
    # let!(:user) {FactoryGirl.create(:technician)}
#     
    # before do 
      # @analysis_type.save
      # @analysis_type.technicians << user
    # end
#        
    # it "should have associated users in alphabetical surname order" do
      # expect(@analysis_type.users.to_a).to eq [user_a, user_b, user_c]
    # end
#     
  # end  
  

end
