require 'rails_helper'

RSpec.describe AnalysisType, type: :model do
  before do 
    @analysis_type = FactoryGirl.create(:analysis_type) 
  end
  
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
      @at_same_name = FactoryGirl.create(:analysis_type) 
      @analysis_type.name = @at_same_name.name
    end
    
    it { should_not be_valid } 
  end
  
  
  describe "technician associations" do  
    let!(:technician_c) {FactoryGirl.create(:technician, surname: 'clarke')}
    let!(:technician_a) {FactoryGirl.create(:technician, surname: 'abbot')}
    let!(:technician_b) {FactoryGirl.create(:technician, surname: 'brown')}
    
    before do 
      #get rid of the initial technician so to compare the order correctly  
      @analysis_type.technicians.destroy(@analysis_type.technicians.first)
      # Add new technicians
      @analysis_type.technicians << technician_b
      @analysis_type.technicians << technician_c
      @analysis_type.technicians << technician_a
      @analysis_type.save
      puts @analysis_type.technicians.to_a.first.surname
    end
       
    it "should have associated technicians in alphabetical surname order" do
      expect(@analysis_type.technicians.to_a).to eq [technician_a, technician_b, technician_c]
    end
    
  end
  
  
  describe "researchers should not be able to be added as technicians" do  
    let!(:researcher) {FactoryGirl.create(:researcher)}
    
    before do 
      @analysis_type.save
      @analysis_type.technicians << researcher
    end
    
    it { should_not be_valid } 
    
  end  
  
  describe "superusers should not be able to be added as technicians" do  
    let!(:superuser) {FactoryGirl.create(:superuser)}
    
    before do 
      @analysis_type.save
      @analysis_type.technicians << superuser
    end
    
    it { should_not be_valid } 
    
  end  
  

end
