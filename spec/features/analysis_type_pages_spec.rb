require 'rails_helper'

RSpec.describe "AnalysisTypes", type: :feature do
  
  subject { page }
  
  let(:researcher)       { FactoryGirl.create(:researcher) }
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
    
    describe "for researchers" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in researcher
          visit new_analysis_type_path
        end
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end

    describe "for technicians" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in technician
          visit new_analysis_type_path
        end
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end
    
    describe "for superusers" do
      before do
        sign_in superuser 
        visit new_analysis_type_path
      end
              
      describe "should be given access to add a new analysis type" do
        it { should have_title('HIE Lab Tracker | New Analysis Type') }
        it { should have_selector('h2', text: "Create New Analysis Type") }
        it { should have_content('Name') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
      end
      
      describe "providing empty information" do                 
        it "should not create an analysis type" do
          expect{ click_button "Submit" }.to change{AnalysisType.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('2 errors') }
          it { should have_selector('h2', text: "Create New Analysis Type") }
        end
      end

      describe "providing invalid information" do   
        before do
          fill_in 'analysis_type_name'  , with: 'a'*81
          fill_in 'analysis_type_instrument'  , with: 'Dummy Instrument'
          fill_in 'analysis_type_description', with: 'This is a description'              
        end
        
        it "should not create an analysis type" do
          expect{ click_button "Submit" }.to change{AnalysisType.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Create New Analysis Type") }
        end
      end
           
      describe "with valid information" do 
        before do
          fill_in 'analysis_type_name'  , with: 'Analysis Type 1'
          fill_in 'analysis_type_instrument'  , with: 'Dummy Instrument'
          fill_in 'analysis_type_description', with: 'This is a description'
        end
        
        it "should create an analysis type" do
          expect { click_button "Submit" }.to change{AnalysisType.count}.by(1)
        end        
        
        describe "should revert to instrument view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Analysis Type created!') }
          it { should have_title(full_title('Analysis Type View')) }  
          it { should have_selector('h2', "Analysis Type") }
        end
      end
  
    end  
    
  end
  
  
  
  
  describe "Show page" do
           
    before do 
      @analysis_type = FactoryGirl.create(:analysis_type)
    end
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit analysis_type_path(@analysis_type) }
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end


    describe "for researchers" do
      describe "should show details of the analysis type" do
        before do 
          sign_in researcher
          visit analysis_type_path(@analysis_type)
        end
        it { should have_title('Analysis Type View') }
        it { should have_selector('h2', text: "Analysis Type " + @analysis_type.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Name') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
        it { should_not have_link('Options') }
        it { should_not have_link('Edit Analysis Type') }
        it { should_not have_link('Delete Analysis Type') }
      end
    end

    
    describe "for technicians" do
      describe "should show details of the analysis type" do
        before do 
          sign_in technician
          visit analysis_type_path(@analysis_type)
        end
        it { should have_title('Analysis Type View') }
        it { should have_selector('h2', text: "Analysis Type " + @analysis_type.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Name') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
        it { should_not have_link('Options') }
        it { should_not have_link('Edit Analysis Type') }
        it { should_not have_link('Delete Analysis Type') }
      end
    end

    
    describe "for superusers who have been marked unapproved" do
      describe "should be redirected to home page with access error message" do
        before do 
          superuser.approved = false
          superuser.save
          sign_in superuser
          visit analysis_type_path(@analysis_type)
        end
        
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end

    describe "for superusers" do
      before do 
        sign_in superuser
        visit analysis_type_path(@analysis_type)
      end
      
      describe "should show details of the analysis type and edit/delete links" do
        it { should have_title('Analysis Type View') }
        it { should have_selector('h2', text: "Analysis Type " + @analysis_type.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Name') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
        it { should have_link('Options') }
        it { should have_link('Edit Analysis Type') }
        it { should have_link('Delete Analysis Type') }
      end
      
      describe "should navigate to correct edit page on following edit link" do
        before { click_link "Edit Analysis Type" }
        let!(:page_heading) {"Edit Analysis Type " + @analysis_type.id.to_s}
        
        # describe 'should have a page heading for editing the correct analysis_type' do
          it { should have_content(page_heading) }
        # end          
      end
      
    end
    
  end


# 
# 
#     
    # describe "for signed-in users who are an owner" do
#       
      # before do 
        # sign_in(user) 
        # visit instrument_path(@instrument)
      # end
#       
      # let!(:page_heading) {"Instrument " + @instrument.id.to_s}
#       
      # it { should have_selector('h2', :text => page_heading) }
      # it { should have_title(full_title('Instrument View')) }
      # it { should_not have_title('| Home') }  
      # it { should have_content('Serial Number') }
      # it { should have_link('Options') }
      # it { should have_link('Edit Instrument') }
      # it { should have_link('Delete Instrument') }
      # it { should have_link('Add Service Record') }
      # it { should have_link('Instrument Loan') }
      # it { should have_link('Instrument Lost') }
      # it { should have_link('Instrument Storage') }
      # it { should have_link('FACE Deployment') }
#       
      # it { should have_content('None assigned') }
#       
      # describe 'should see model details' do
        # it { should have_content('Manufacturer') }
      # end
#       
      # describe 'should see current status' do
        # it { should have_content('Current Status') }
      # end
#       
      # describe 'should have correct current status details' do
        # let!(:newest_status) { FactoryGirl.create(:lost, startdate:Date.today, instrument:@instrument) }
#         
        # before { visit instrument_path(@instrument) }
#         
        # it { should have_content('Lost') }
        # it { should have_content('View Details') }
      # end
#       
      # describe "when clicking the edit button" do
        # before { click_link "Edit Instrument" }
        # let!(:page_heading) {"Edit Instrument " + @instrument.id.to_s}
#         
        # describe 'should have a page heading for editing the correct instrument' do
          # it { should have_content(page_heading) }
        # end
      # end 
#       
      # describe "when clicking the add service button" do
        # before { click_link "Add Service Record" }
        # let!(:page_heading) {"New Service Record for Instrument " + @instrument.id.to_s}
#         
        # describe 'should have a page heading for the correct service record' do
          # it { should have_content(page_heading) }
        # end
      # end 
#       
      # describe "when clicking the instrument loan button" do
        # before { click_link "Instrument Loan" }
        # let!(:page_heading) {"New Loan Record for Instrument " + @instrument.id.to_s}
#         
        # describe 'should have a page heading for the correct service record' do
          # it { should have_content(page_heading) }
        # end
      # end 
#       
      # describe "when clicking the instrument lost button" do
        # before { click_link "Instrument Lost" }
        # let!(:page_heading) {"New Lost Record for Instrument " + @instrument.id.to_s}
#         
        # describe 'should have a page heading for the correct service record' do
          # it { should have_content(page_heading) }
        # end
      # end 
#  
      # describe "when clicking the face deployment button" do
        # before { click_link "FACE Deployment" }
        # let!(:page_heading) {"New FACE Deployment Record for Instrument " + @instrument.id.to_s}
#         
        # describe 'should have a page heading for the correct service record' do
          # it { should have_content(page_heading) }
        # end
      # end 
#  
      # describe "when clicking the storage button" do
        # before { click_link "Instrument Storage" }
        # let!(:page_heading) {"New In Storage Record for Instrument " + @instrument.id.to_s}
#         
        # describe 'should have a page heading for the correct status record' do
          # it { should have_content(page_heading) }
        # end
      # end 
#            
      # describe "should show correct user/owner associations" do
        # let!(:new_user1) { FactoryGirl.create(:user) }
        # let!(:new_user2) { FactoryGirl.create(:user) }
#         
        # before do         
          # @instrument.users << new_user1
          # @instrument.users << new_user2
          # visit instrument_path(@instrument)
        # end
#         
        # it { should have_content('Contacts for this Instrument') }
        # it { should have_content(user.firstname) }  
        # it { should have_content(new_user1.firstname) }  
        # it { should have_content(new_user2.firstname) }  
#               
      # end
#       
      # describe "should show correct services associations" do
        # let!(:first_service) { FactoryGirl.create(:service, instrument_id:@instrument.id ) }
        # let!(:second_service) { FactoryGirl.create(:service, instrument_id:@instrument.id ) }
#         
        # before do 
          # visit instrument_path(@instrument)
        # end
#         
        # it { should have_content('Service History for this Instrument') }
        # it { should have_selector('table tr th', text: 'Service ID') } 
        # it { should have_selector('table tr td', text: first_service.id) } 
        # it { should have_selector('table tr td', text: second_service.id) }             
      # end
#       
#       
      # describe "should show correct statuses associations" do
        # let!(:first_status) { FactoryGirl.create(:loan, instrument_id:@instrument.id, reporter: user ) }
        # let!(:second_status) { FactoryGirl.create(:lost, instrument_id:@instrument.id, reporter: user ) }
        # let!(:third_status) { FactoryGirl.create(:facedeployment, instrument_id:@instrument.id, reporter: user ) }
#         
        # before do 
          # visit instrument_path(@instrument)
        # end
#         
        # it { should have_content('Status History for this Instrument') }
        # it { should have_selector('table tr th', text: 'ID') } 
        # it { should have_selector('table tr td', text: first_status.id) } 
        # it { should have_selector('table tr td', text: second_status.id) }             
        # it { should have_selector('table tr td', text: third_status.id) }             
      # end
#       
    # end
#     
    # describe "who don't own the current instrument" do
       # let(:non_owner) { FactoryGirl.create(:user) }
       # before do 
         # sign_in(non_owner)
         # visit instrument_path(@instrument)
       # end 
#        
       # let!(:page_heading) {"Instrument " + @instrument.id.to_s}
#         
       # describe 'should have a page heading for the correct instrument' do
          # it { should have_selector('h2', :text => page_heading) }
       # end
#        
       # describe 'should see model details' do
          # it { should have_content('Manufacturer') }
       # end
#        
       # describe "should not see the edit and delete buttons" do
         # it { should_not have_link('Edit Container') }
         # it { should_not have_link('Delete Container') }
       # end 
#        
       # describe "should show correct services associations" do
        # let!(:first_service) { FactoryGirl.create(:service, instrument_id:@instrument.id ) }
        # let!(:second_service) { FactoryGirl.create(:service, instrument_id:@instrument.id ) }
#         
        # before do 
          # visit instrument_path(@instrument)
        # end
#         
        # it { should have_content('Service History for this Instrument') }
        # it { should have_selector('table tr th', text: 'Service ID') } 
        # it { should have_selector('table tr td', text: first_service.id) } 
        # it { should have_selector('table tr td', text: second_service.id) } 
#               
      # end
    # end
#     
    # describe "for non signed-in users" do
      # describe "should still see the page but have no option button be redirected back to signin" do
        # before do 
         # visit instrument_path(@instrument)
        # end 
#         
        # let!(:page_heading) {"Instrument " + @instrument.id.to_s}
#         
        # describe 'should have a page heading for the correct instrument' do
          # it { should have_selector('h2', :text => page_heading) }
        # end
#         
        # describe 'should see model details' do
          # it { should have_content('Manufacturer') }
        # end
#        
        # describe "should not see the edit and delete buttons" do
          # it { should_not have_link('Edit Container') }
          # it { should_not have_link('Delete Container') }
        # end 
#         
        # describe "should show correct services associations" do
          # let!(:first_service) { FactoryGirl.create(:service, instrument_id:@instrument.id ) }
          # let!(:second_service) { FactoryGirl.create(:service, instrument_id:@instrument.id ) }
#           
          # before do 
            # visit instrument_path(@instrument)
          # end
#           
          # it { should have_content('Service History for this Instrument') }
          # it { should have_selector('table tr th', text: 'Service ID') } 
          # it { should have_selector('table tr td', text: first_service.id) } 
          # it { should have_selector('table tr td', text: second_service.id) } 
#                 
        # end
#         
      # end
    # end
#     
  
  
  
  
  
  
  
  
  
  
  
  
  describe "Edit page" do
    
    before do 
      @analysis_type = FactoryGirl.create(:analysis_type)
    end 
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit edit_analysis_type_path(@analysis_type) }
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end


    describe "for researchers" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in researcher
          visit edit_analysis_type_path(@analysis_type)
        end
        
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end
    
    
    describe "for technicians" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in technician
          visit edit_analysis_type_path(@analysis_type)
        end
        
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end
    
    
    describe "for superusers" do
      before do
        sign_in superuser 
        visit edit_analysis_type_path(@analysis_type)
      end
              
      describe "should be given access to edit analysis type" do
        it { should have_title('HIE Lab Tracker | Edit Analysis Type') }
        it { should have_selector('h2', text: "Edit Analysis Type "+@analysis_type.id.to_s) }
        it { should have_content('Name') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of analysis types" do
          expect{ click_button "Update" }.to change{AnalysisType.count}.by(0)
        end             
        
        describe "should return " do
          before { click_button "Update" }
          it { should have_title('Analysis Type View') }
          it { should have_selector('h2', text: "Analysis Type " + @analysis_type.id.to_s) }
        end
      end
      
      describe "providing empty information" do   
        before do
          fill_in 'analysis_type_name'  , with: ''
          fill_in 'analysis_type_instrument'  , with: ''
          fill_in 'analysis_type_description', with: ''              
        end
        
        it "should not change number of analysis types" do
          expect{ click_button "Update" }.to change{AnalysisType.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('2 errors') }
          it { should have_selector('h2', text: "Edit Analysis Type "+@analysis_type.id.to_s) }
        end
      end

      describe "providing invalid information" do   
        before do
          fill_in 'analysis_type_name'  , with: 'a'*81
          fill_in 'analysis_type_instrument'  , with: 'Dummy Instrument'
          fill_in 'analysis_type_description', with: 'This is a description'              
        end
        
        it "should not create an analysis type" do
          expect{ click_button "Update" }.to change{AnalysisType.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Edit Analysis Type "+@analysis_type.id.to_s) }
        end
      end
           
      describe "with valid information" do 
        before do
          fill_in 'analysis_type_name'  , with: 'Analysis Type X'
          fill_in 'analysis_type_instrument'  , with: 'Dummy Instrument X'
          fill_in 'analysis_type_description', with: 'This is a description X'
        end
        
        it "should keep the same number of Analysis Types" do
          expect { click_button "Update" }.to change{AnalysisType.count}.by(0)
        end        
        
        describe "should revert to analysis type view page with success message and updated info" do
          before { click_button "Update" }
          it { should have_content('Analysis Type Updated!') }
          it { should have_content('Analysis Type X') }
          it { should have_content('Dummy Instrument X') }
          it { should have_content('This is a description X') }
          it { should have_title(full_title('Analysis Type View')) }  
          it { should have_selector('h2', text: "Analysis Type "+@analysis_type.id.to_s) }
        end
      end
  
    end  
    
    
    
    
    # describe "for signed-in users who are an owner" do
#       
      # before do 
        # sign_in(user) 
        # visit edit_instrument_path(@instrument)
      # end 
#       
      # it { should have_content('Edit Instrument ' + @instrument.id.to_s) }
      # it { should have_title(full_title('Edit Instrument')) }
      # it { should_not have_title('| Home') }
#       
      # describe "with invalid serial number information" do
#         
          # before do
            # fill_in 'instrument_serialNumber', with: ''
            # click_button "Update"
          # end
#           
          # describe "should return an error" do
            # it { should have_content('error') }
          # end
#   
      # end
#       
      # describe "with invalid model choice" do
#         
          # before do
            # find('#models').find(:xpath, 'option[1]').select_option
            # click_button "Update"
          # end
#           
          # describe "should return an error" do
            # it { should have_content("Model is required") }
          # end
#   
      # end
#   
      # describe "with valid information" do
#   
        # before do
          # fill_in 'instrument_serialNumber'  , with: 'dummyserial'
          # fill_in 'instrument_price'   , with: 678.00
        # end
#         
        # it "should update, not add an instrument" do
          # expect { click_button "Update" }.not_to change(Instrument, :count).by(1)
        # end
#         
        # describe "should return to view page" do
          # before { click_button "Update" }
          # it { should have_content('Instrument updated') }
          # it { should have_title(full_title('Instrument View')) }
        # end
#       
      # end
#       
    # end  
#     
    # describe "for signed-in users who are not an owner" do
      # let(:non_owner) { FactoryGirl.create(:user) }
      # before do 
        # sign_in(non_owner)
        # visit edit_instrument_path(@instrument)
      # end 
#       
      # describe 'should have a page heading for the correct instrument' do
        # it { should_not have_content('Edit') }
        # it { should have_title('Home') }
        # it { should have_content('Welcome to HIE Instrument Tracker') }
      # end
    # end
#     
    # describe "for non signed-in users" do
      # describe "should be redirected back to signin" do
        # before { visit edit_instrument_path(@instrument) }
        # it { should have_title('Sign in') }
      # end
    # end
    
  end
  
  

end
