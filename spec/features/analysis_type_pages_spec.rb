require 'rails_helper'

RSpec.describe "AnalysisTypes", type: :feature do
  
  subject { page }
  
  let(:user)       { FactoryGirl.create(:user) }
  let(:technician) { FactoryGirl.create(:technician) }
  let(:superuser)  { FactoryGirl.create(:superuser) }


  describe "New page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit new_analysis_type_path }
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end
    
    describe "for normal users" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in user
          visit new_analysis_type_path
        end
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end

    describe "for technicians" do
      describe "You are not authorized to access this page." do
        before do 
          sign_in technician
          visit new_analysis_type_path
        end
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end
    
    describe "for superusers" do
      describe "should be given access to add a new analysis type" do
        before do 
          sign_in superuser
          visit new_analysis_type_path
        end
        it { should have_title('HIE Lab Tracker | New Analysis Type') }
        it { should have_content("New Analysis Type") }
      end
    end
  
  end  
    
    # describe "for signed-in users with models in the system" do
#       
      # let!(:mymod) { FactoryGirl.create(:model) } # Needed to make sure something appears in the dropdown
      # let!(:user2) { FactoryGirl.create(:user) }  # An additional user
#       
      # before do 
        # sign_in user
        # visit new_instrument_path
      # end          
#       
      # it { should have_content('New Instrument') }
      # it { should have_title(full_title('New Instrument')) }
      # it { should_not have_title('| Home') }
      # it { should have_content('Additional Owners') }
      # #only user 2 should be showing in the dropdown menu (not the creating user)
      # it { should have_content(user2.firstname+' '+user2.surname) }
      # it { should_not have_content(user.firstname+' '+user.surname) }
#       
#      
      # describe "with invalid information" do                 
        # it "should not create an instrument" do
          # expect{  click_button "Submit" }.to change{Instrument.count}.by(0)
        # end
      # end
#      
      # describe "with valid information" do 
        # before do
          # find('#models').find(:xpath, 'option[2]').select_option
          # fill_in 'instrument_assetNumber'  , with: 'dasdasdadsa'
          # fill_in 'instrument_supplier'  , with: 'Dummy Supplier Inc'
          # fill_in 'instrument_serialNumber', with: 'fsdfjhkds'
          # fill_in 'instrument_purchaseDate', with: Date.new(2012, 12, 3)
          # fill_in 'instrument_price', with: 2430.00
        # end
#         
        # it "should create a instrument" do
          # expect { click_button "Submit" }.to change{Instrument.count}.by(1)
        # end        
#         
        # describe "should revert to instrument view page" do
          # before { click_button "Submit" }
          # it { should have_content('Instrument created!') }
          # it { should have_title(full_title('Instrument View')) }  
          # it { should have_selector('h2', "Instrument") }
        # end
#         
        # describe "including an additional owner" do
          # before do 
            # find('#users').find(:xpath, 'option[1]').select_option
          # end 
#           
          # it "should create a instrument" do
            # expect { click_button "Submit" }.to change{Instrument.count}.by(1)
          # end    
#           
          # describe "should revert to instrument view page" do
            # before { click_button "Submit" }         
            # it { should have_content('Instrument created!') }
            # it { should have_title(full_title('Instrument View')) }  
            # it { should have_selector('h2', "Instrument") }
          # end
        # end
#         
      # end  
#       
    # end
#     
    # describe "for non signed-in users" do
      # describe "should be redirected back to signin" do
        # before { visit new_instrument_path }
        # it { should have_title('Sign in') }
      # end
    # end
#     
  # end  

end
