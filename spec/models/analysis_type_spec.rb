require 'rails_helper'

RSpec.describe AnalysisType, type: :model do
  before { @analysis_type = FactoryGirl.build(:analysis_type) }
  subject { @analysis_type }

  it { should respond_to(:name) }
  it { should respond_to(:instrument) }
  it { should respond_to(:description) }

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

end
