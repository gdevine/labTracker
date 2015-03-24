require 'rails_helper'

RSpec.describe "JobRequests", type: :feature do
  
  subject { page }
  
  let(:researcher) { FactoryGirl.create(:researcher) }
  let(:technician) { FactoryGirl.create(:technician) }
  let(:superuser)  { FactoryGirl.create(:superuser) }
  
  
  describe "Index page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit job_requests_path }
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end
    
    describe "for researchers" do
      before { sign_in researcher }
      
      describe "with no job_requests in the system" do
        before { visit job_requests_path }
        
        it { should have_title('Job Requests') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Job Requests") }
        it "should have an information message" do
          expect(page).to have_content('No Job Requests found')
        end
      end
    
      describe "with job requests in the system" do
        before do 
          @jr1 = FactoryGirl.create(:job_request)
          @jr2 = FactoryGirl.create(:job_request)
          @jr3 = FactoryGirl.create(:job_request)
          visit job_requests_path
        end
        
        it { should have_content('ID') }
        it { should have_content('Analysis Type') }
        it { should have_content('Researcher') }
        it { should have_content('Requested on') }
        it { should have_content(@jr1.id) }
        it { should have_content(@jr2.id) }
        it { should have_content(@jr3.id) }
        it { should have_content(@jr1.created_at.strftime('%a %b %d %Y')) }
        it { should have_content(@jr2.created_at.strftime('%a %b %d %Y')) }
        it { should have_content(@jr3.created_at.strftime('%a %b %d %Y')) }
        it { should have_content(@jr1.researcher.fullname) }
        it { should have_content(@jr2.researcher.fullname) }
        it { should have_content(@jr3.researcher.fullname) }
        it { should have_link('View', :href => job_request_path(@jr1)) }
        it { should have_link('View', :href => job_request_path(@jr2)) }
        it { should have_link('View', :href => job_request_path(@jr3)) }
        
        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{job_request_path(@jr1)}']").click }
          it { should have_selector('h2', text: "Job Request " + @jr1.id.to_s) }  
        end
      
      end
    end
    
    describe "for technicians" do
      before { sign_in technician }
      
      describe "with no job requests in the system" do
        before { visit job_requests_path }
        
        it { should have_title('Job Requests') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Job Requests") }
        it "should have an information message" do
          expect(page).to have_content('No Job Requests found')
        end
      end
    
      describe "with job requests in the system" do
        before do 
          @jr1 = FactoryGirl.create(:job_request)
          @jr2 = FactoryGirl.create(:job_request)
          @jr3 = FactoryGirl.create(:job_request)
          visit job_requests_path
        end
        
        it { should have_content('ID') }
        it { should have_content('Analysis Type') }
        it { should have_content('Researcher') }
        it { should have_content('Requested on') }
        it { should have_content(@jr1.id) }
        it { should have_content(@jr2.id) }
        it { should have_content(@jr3.id) }
        it { should have_content(@jr1.created_at.strftime('%a %b %d %Y')) }
        it { should have_content(@jr2.created_at.strftime('%a %b %d %Y')) }
        it { should have_content(@jr3.created_at.strftime('%a %b %d %Y')) }
        it { should have_content(@jr1.researcher.fullname) }
        it { should have_content(@jr2.researcher.fullname) }
        it { should have_content(@jr3.researcher.fullname) }
        it { should have_link('View', :href => job_request_path(@jr1)) }
        it { should have_link('View', :href => job_request_path(@jr2)) }
        it { should have_link('View', :href => job_request_path(@jr3)) }
        
        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{job_request_path(@jr1)}']").click }
          it { should have_selector('h2', text: "Job Request " + @jr1.id.to_s) }  
        end
      
      end
    end
    
    
    describe "for superusers" do
      before { sign_in superuser }
      
        
      describe "with no job requests in the system" do
        before { visit job_requests_path }
        
        it { should have_title('Job Requests') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Job Requests") }
        it "should have an information message" do
          expect(page).to have_content('No Job Requests found')
        end
      end
    
      describe "with job requests in the system" do
        before do 
          @jr1 = FactoryGirl.create(:job_request)
          @jr2 = FactoryGirl.create(:job_request)
          @jr3 = FactoryGirl.create(:job_request)
          visit job_requests_path
        end
        
        it { should have_content('ID') }
        it { should have_content('Analysis Type') }
        it { should have_content('Researcher') }
        it { should have_content('Requested on') }
        it { should have_content(@jr1.id) }
        it { should have_content(@jr2.id) }
        it { should have_content(@jr3.id) }
        it { should have_content(@jr1.created_at.strftime('%a %b %d %Y')) }
        it { should have_content(@jr2.created_at.strftime('%a %b %d %Y')) }
        it { should have_content(@jr3.created_at.strftime('%a %b %d %Y')) }
        it { should have_content(@jr1.researcher.fullname) }
        it { should have_content(@jr2.researcher.fullname) }
        it { should have_content(@jr3.researcher.fullname) }
        it { should have_link('View', :href => job_request_path(@jr1)) }
        it { should have_link('View', :href => job_request_path(@jr2)) }
        it { should have_link('View', :href => job_request_path(@jr3)) }
        
        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{job_request_path(@jr1)}']").click }
          it { should have_selector('h2', text: "Job Request " + @jr1.id.to_s) }  
        end
      
      end
    end
   
  end


  describe "New page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit new_job_request_path }
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end
    
    describe "for superusers" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in superuser
          visit new_job_request_path
        end
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end

    describe "for technicians" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in technician
          visit new_job_request_path
        end
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end

    describe "for researchers with no analysis types in the system" do
      before do
        sign_in researcher
        visit new_job_request_path
      end
              
      describe "should not be able to create a new job request" do
        it { should_not have_title('HIE Lab Tracker | New Job Request') }
        it { should_not have_selector('h2', text: "Create New Job Request") }
        it { should_not have_content('Samples') }
        it { should_not have_content('Project') }
        it { should have_content('New Job Requests cannot be created until at least one Analysis Type is added to the system. Contact the admin to do this.') }
      end
    end
    
    describe "for researchers with analysis types in the system" do
      before do
        @at1 = FactoryGirl.create(:analysis_type)
        sign_in researcher
        visit new_job_request_path
      end
              
      describe "should be given access to create a new job request" do
        it { should have_title('HIE Lab Tracker | New Job Request') }
        it { should have_selector('h2', text: "Create New Job Request") }
        it { should have_content('Analysis Type') }
        it { should_not have_content('New Job Requests cannot be created until at least one Analysis Type is added to the system. Contact the admin to do this.') }
        it { should have_content('Project') }
        it { should have_content('Comments') }
        it { should have_content('Samples') }
        it { should have_content(@at1.name) }
      end
      
      describe "providing empty information" do                 
        it "should not create a job request" do
          expect{ click_button "Submit" }.to change{JobRequest.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('3 errors') }
          it { should have_selector('h2', text: "Create New Job Request") }
        end
      end

      describe "providing invalid information" do   
        before do
          fill_in 'job_request_project'  , with: ''
          fill_in 'job_request_comments'  , with: 'This is a comment'
          fill_in 'job_request_samples', with: '1, 3, 4-6, 65'   
          find('#analysis_types').find(:xpath, 'option[2]').select_option           
        end
        
        it "should not create an analysis type" do
          expect{ click_button "Submit" }.to change{AnalysisType.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Create New Job Request") }
        end
      end
           
      describe "with valid information" do 
        before do
          fill_in 'job_request_project'  , with: 'Project 1'
          fill_in 'job_request_comments'  , with: 'This is a comment'
          fill_in 'job_request_samples', with: '1, 3, 4-6, 65'   
          find('#analysis_types').find(:xpath, 'option[2]').select_option            
        end
        
        it "should create a job request" do
          expect { click_button "Submit" }.to change{JobRequest.count}.by(1)
        end        
        
        describe "should revert to job request view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Job Request created!') }
          it { should have_title(full_title('Job Request View')) }  
          it { should have_selector('h2', "Job Request") }
          it { should have_content(researcher.fullname) }
        end
      end
  
    end  
    
  end
  
  
  describe "Show page" do
           
    before do 
      @job_request = FactoryGirl.create(:job_request)
    end
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit job_request_path(@job_request) }
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end


    describe "for researchers who requested the job" do
      describe "should show details of the job request" do
        before do 
          @job_request.researcher = researcher
          @job_request.save
          sign_in researcher
          visit job_request_path(@job_request)
        end
        it { should have_title('Job Request View') }
        it { should have_selector('h2', text: "Job Request " + @job_request.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Analysis Type') }
        it { should have_content('Project') }
        it { should have_content('Samples') }
        it { should have_content('Requested by') }
        it { should have_content('Requested on') }
        it { should have_content('Comments') }
        it { should have_content(@job_request.project) }
        it { should have_content(@job_request.analysis_type.name) }
        it { should have_content(researcher.fullname) }
        it { should have_link('Options') }
        it { should have_link('Edit Job Request') }
        it { should have_link('Delete Job Request') }
      end
      
      describe "should navigate to correct edit page on following edit link" do
        before { click_link "Edit Job Request" }
        let!(:page_heading) {"Edit Job Request " + @job_request.id.to_s}
        
        it { should have_content(page_heading) }
      end
    end
    
    describe "for researchers (who did not request the job)" do
      describe "should show details of the job request" do
        
        before do 
          sign_in researcher
          visit job_request_path(@job_request)
        end
        it { should have_title('Job Request View') }
        it { should have_selector('h2', text: "Job Request " + @job_request.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Analysis Type') }
        it { should have_content('Project') }
        it { should have_content('Samples') }
        it { should have_content('Requested by') }
        it { should have_content('Requested on') }
        it { should have_content('Comments') }
        it { should have_content(@job_request.project) }
        it { should have_content(@job_request.analysis_type.name) }
        it { should have_content(@job_request.researcher.fullname) }
        it { should_not have_link('Options') }
        it { should_not have_link('Edit Job Request') }
        it { should_not have_link('Delete Job request') }
      end
        
    end
      
      
    describe "for technicians" do
      describe "should show details of the job request" do
        
        before do 
          sign_in technician
          visit job_request_path(@job_request)
        end
        it { should have_title('Job Request View') }
        it { should have_selector('h2', text: "Job Request " + @job_request.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Analysis Type') }
        it { should have_content('Project') }
        it { should have_content('Samples') }
        it { should have_content('Requested by') }
        it { should have_content('Requested on') }
        it { should have_content('Comments') }
        it { should have_content(@job_request.project) }
        it { should have_content(@job_request.analysis_type.name) }
        it { should have_content(@job_request.researcher.fullname) }
        it { should_not have_link('Options') }
        it { should_not have_link('Edit Job Request') }
        it { should_not have_link('Delete Job request') }
      end
      
    end
      
    describe "for superusers" do
      describe "should show details of the job request" do
      
        before do 
          sign_in superuser
          visit job_request_path(@job_request)
        end
        it { should have_title('Job Request View') }
        it { should have_selector('h2', text: "Job Request " + @job_request.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Analysis Type') }
        it { should have_content('Project') }
        it { should have_content('Samples') }
        it { should have_content('Requested by') }
        it { should have_content('Requested on') }
        it { should have_content('Comments') }
        it { should have_content(@job_request.project) }
        it { should have_content(@job_request.analysis_type.name) }
        it { should have_content(@job_request.researcher.fullname) }
        it { should_not have_link('Options') }
        it { should_not have_link('Edit Job Request') }
        it { should_not have_link('Delete Job request') }
      end
      
    end   
    
    describe "for researchers who have been marked unapproved" do
      describe "should be redirected to home page with access error message" do
        before do 
          researcher.approved = false
          researcher.save
          sign_in researcher
          visit job_request_path(@job_request)
        end
        
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end
    
    describe "for superusers who have been marked unapproved" do
      describe "should be redirected to home page with access error message" do
        before do 
          superuser.approved = false
          superuser.save
          sign_in superuser
          visit job_request_path(@job_request)
        end
        
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end

  end

  
  # describe "Edit page" do
#     
    # before do 
      # @analysis_type = FactoryGirl.build(:analysis_type)
      # @analysis_type.technicians << technician
      # @analysis_type.save
    # end 
#     
    # describe "for non signed-in users" do
      # describe "should be redirected to home page with access error message" do
        # before { visit edit_analysis_type_path(@analysis_type) }
        # it { should have_title('HIE Lab Tracker | Home') }
        # it { should have_content("You are not authorized to access this page.") }
      # end
    # end
# 
# 
    # describe "for researchers" do
      # describe "should be redirected to home page with access error message" do
        # before do 
          # sign_in researcher
          # visit edit_analysis_type_path(@analysis_type)
        # end
#         
        # it { should have_title('HIE Lab Tracker | Home') }
        # it { should have_content("You are not authorized to access this page.") }
      # end
    # end
#     
#     
    # describe "for technicians" do
      # describe "should be redirected to home page with access error message" do
        # before do 
          # sign_in technician
          # visit edit_analysis_type_path(@analysis_type)
        # end
#         
        # it { should have_title('HIE Lab Tracker | Home') }
        # it { should have_content("You are not authorized to access this page.") }
      # end
    # end
#     
#     
    # describe "for superusers" do
      # before do
        # @tech1 = FactoryGirl.create(:technician)
        # @tech2 = FactoryGirl.create(:technician)
        # @res1 = FactoryGirl.create(:researcher)
        # @analysis_type.technicians << @tech1
        # @analysis_type.technicians << @tech2
        # sign_in superuser 
        # visit edit_analysis_type_path(@analysis_type)
      # end
#               
      # describe "should be given access to edit analysis type" do
        # it { should have_title('HIE Lab Tracker | Edit Analysis Type') }
        # it { should have_selector('h2', text: "Edit Analysis Type "+@analysis_type.id.to_s) }
        # it { should have_content('Name') }
        # it { should have_content('Instrument') }
        # it { should have_content('Description') }
        # it { should have_content('Assigned Technicians') }
        # it { should have_content(@tech1.fullname) }
        # it { should have_content(@tech2.fullname) }
        # it { should_not have_content(@res1.fullname) }
      # end
#       
      # describe "not changing any information" do                 
        # it "should not change the number of analysis types" do
          # expect{ click_button "Update" }.to change{AnalysisType.count}.by(0)
        # end             
#         
        # describe "should return to view" do
          # before { click_button "Update" }
          # it { should have_title('Analysis Type View') }
          # it { should have_selector('h2', text: "Analysis Type " + @analysis_type.id.to_s) }
        # end
      # end
#       
      # describe "providing empty information" do   
        # before do
          # fill_in 'analysis_type_name'  , with: ''
          # fill_in 'analysis_type_instrument'  , with: ''
          # fill_in 'analysis_type_description', with: ''              
        # end
#         
        # it "should not change number of analysis types" do
          # expect{ click_button "Update" }.to change{AnalysisType.count}.by(0)
        # end             
#         
        # describe "should return an error and revert back" do
          # before { click_button "Update" }
          # it { should have_content('2 errors') }
          # it { should have_selector('h2', text: "Edit Analysis Type "+@analysis_type.id.to_s) }
        # end
      # end
# 
      # describe "removing technicians" do   
        # before do
          # find('#technicians').find(:xpath, 'option[1]').unselect_option  
          # find('#technicians').find(:xpath, 'option[2]').unselect_option  
          # find('#technicians').find(:xpath, 'option[3]').unselect_option  
        # end
#         
        # it "should not create an analysis type" do
          # expect{ click_button "Update" }.to change{AnalysisType.count}.by(0)
        # end             
#         
        # describe "should return an error and revert back" do
          # before { click_button "Update" }
          # it { should have_content('1 error') }
          # it { should have_selector('h2', text: "Edit Analysis Type "+@analysis_type.id.to_s) }
        # end
      # end
# 
      # describe "providing invalid information" do   
        # before do
          # fill_in 'analysis_type_name'  , with: 'a'*81
          # fill_in 'analysis_type_instrument'  , with: 'Dummy Instrument'
          # fill_in 'analysis_type_description', with: 'This is a description'              
          # find('#technicians').find(:xpath, 'option[2]').unselect_option  
        # end
#         
        # it "should not create an analysis type" do
          # expect{ click_button "Update" }.to change{AnalysisType.count}.by(0)
        # end             
#         
        # describe "should return an error and revert back" do
          # before { click_button "Update" }
          # it { should have_content('1 error') }
          # it { should have_selector('h2', text: "Edit Analysis Type "+@analysis_type.id.to_s) }
        # end
      # end
#            
      # describe "with valid information" do 
        # before do
          # fill_in 'analysis_type_name'  , with: 'Analysis Type X'
          # fill_in 'analysis_type_instrument'  , with: 'Dummy Instrument X'
          # fill_in 'analysis_type_description', with: 'This is a description X'
        # end
#         
        # it "should keep the same number of Analysis Types" do
          # expect { click_button "Update" }.to change{AnalysisType.count}.by(0)
        # end        
#         
        # describe "should revert to analysis type view page with success message and updated info" do
          # before { click_button "Update" }
          # it { should have_content('Analysis Type Updated!') }
          # it { should have_content('Analysis Type X') }
          # it { should have_content('Dummy Instrument X') }
          # it { should have_content('This is a description X') }
          # it { should have_title(full_title('Analysis Type View')) }  
          # it { should have_selector('h2', text: "Analysis Type "+@analysis_type.id.to_s) }
        # end
      # end
#   
    # end  
#     
  # end
#   
#   
  # describe "Analysis Type Deletion" do
#     
    # before do 
      # @analysis_type = FactoryGirl.build(:analysis_type) 
      # @analysis_type.technicians << technician
      # @analysis_type.save
      # sign_in superuser
      # visit analysis_type_path(@analysis_type)
    # end
#     
    # it "should delete" do
      # expect { click_link "Delete Analysis Type" }.to change(AnalysisType, :count).by(-1)
    # end
#     
    # describe "should revert to analysis type list page with success message and updated info" do
      # before { click_link "Delete Analysis Type" }
      # it { should have_content('Analysis Type Deleted!') }
      # it { should have_content('No Analysis Types found') }
      # it { should have_title(full_title('Analysis Types')) }  
      # it { should_not have_link('View', :href => analysis_type_path(@analysis_type)) }
    # end
#   
  # end
  
  
end
