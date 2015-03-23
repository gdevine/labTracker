require 'rails_helper'

RSpec.describe "AnalysisTypes", type: :feature do
  
  subject { page }
  
  let(:researcher) { FactoryGirl.create(:researcher) }
  let(:technician) { FactoryGirl.create(:technician) }
  let(:superuser)  { FactoryGirl.create(:superuser) }
  
  
  describe "Index page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit analysis_types_path }
        it { should have_title('HIE Lab Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end
    
    describe "for researchers" do
      before { sign_in researcher }
      
      describe "with no analysis types in the system" do
        before { visit analysis_types_path }
        
        it { should have_title('Analysis Types') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Available Analysis Types") }
        it "should have an information message" do
          expect(page).to have_content('No Analysis Types found')
        end
      end
    
      describe "with analysis types in the system" do
        before do 
          @at1 = FactoryGirl.build(:analysis_type)
          @at2 = FactoryGirl.build(:analysis_type)
          @at3 = FactoryGirl.build(:analysis_type)
          @at1.technicians << technician
          @at2.technicians << technician
          @at3.technicians << technician
          @at1.save
          @at2.save
          @at3.save
          visit analysis_types_path
        end
        
        it { should have_content('Name') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
        it { should have_content(@at1.name) }
        it { should have_content(@at2.name) }
        it { should have_content(@at3.name) }
        it { should have_link('View', :href => analysis_type_path(@at1)) }
        it { should have_link('View', :href => analysis_type_path(@at3)) }
        it { should have_link('View', :href => analysis_type_path(@at3)) }
        
        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{analysis_type_path(@at1)}']").click }
          it { should have_selector('h2', text: "Analysis Type " + @at1.id.to_s) }  
        end
      
      end
    end
    
    describe "for technicians" do
      before { sign_in technician }
      
      describe "with no analysis types in the system" do
        before { visit analysis_types_path }
        
        it { should have_title('Analysis Types') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Available Analysis Types") }
        it "should have an information message" do
          expect(page).to have_content('No Analysis Types found')
        end
      end
    
      describe "with analysis types in the system" do
        before do 
          @at1 = FactoryGirl.build(:analysis_type)
          @at2 = FactoryGirl.build(:analysis_type)
          @at3 = FactoryGirl.build(:analysis_type)
          @at1.technicians << technician
          @at2.technicians << technician
          @at3.technicians << technician
          @at1.save
          @at2.save
          @at3.save
          visit analysis_types_path
        end
        
        it { should have_content('Name') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
        it { should have_content(@at1.name) }
        it { should have_content(@at2.name) }
        it { should have_content(@at3.name) }
        it { should have_link('View', :href => analysis_type_path(@at1)) }
        it { should have_link('View', :href => analysis_type_path(@at3)) }
        it { should have_link('View', :href => analysis_type_path(@at3)) }
        
        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{analysis_type_path(@at1)}']").click }
          it { should have_selector('h2', text: "Analysis Type " + @at1.id.to_s) }  
        end
      
      end
    end
    
    
    describe "for superusers" do
      before { sign_in superuser }
      
      describe "with no analysis types in the system" do
        before { visit analysis_types_path }
        
        it { should have_title('Analysis Types') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Available Analysis Types") }
        it "should have an information message" do
          expect(page).to have_content('No Analysis Types found')
        end
      end
    
      describe "with analysis types in the system" do
        before do 
          @at1 = FactoryGirl.build(:analysis_type)
          @at2 = FactoryGirl.build(:analysis_type)
          @at3 = FactoryGirl.build(:analysis_type)
          @at1.technicians << technician
          @at2.technicians << technician
          @at3.technicians << technician
          @at1.save
          @at2.save
          @at3.save
          visit analysis_types_path
        end
        
        it { should have_content('Name') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
        it { should have_content(@at1.name) }
        it { should have_content(@at2.name) }
        it { should have_content(@at3.name) }
        it { should have_link('View', :href => analysis_type_path(@at1)) }
        it { should have_link('View', :href => analysis_type_path(@at3)) }
        it { should have_link('View', :href => analysis_type_path(@at3)) }
        
        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{analysis_type_path(@at1)}']").click }
          it { should have_selector('h2', text: "Analysis Type " + @at1.id.to_s) }  
        end
      
      end
    end
   
  end


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

    describe "for superusers with no technicians in the system" do
      before do
        sign_in superuser
        visit new_analysis_type_path
      end
              
      describe "should not be able to add a new analysis type" do
        it { should_not have_title('HIE Lab Tracker | New Analysis Type') }
        it { should_not have_selector('h2', text: "Create New Analysis Type") }
        it { should_not have_content('Name') }
        it { should have_content('New Analysis Types cannot be added until at least one Technician is added to the system. Contact the admin to do this.') }
      end
    end
    
    describe "for superusers with technicians in the system" do
      before do
        @tech1 = FactoryGirl.create(:technician)
        @tech2 = FactoryGirl.create(:technician)
        @res1 = FactoryGirl.create(:researcher)
        sign_in superuser
        visit new_analysis_type_path
      end
              
      describe "should be given access to add a new analysis type" do
        it { should have_title('HIE Lab Tracker | New Analysis Type') }
        it { should have_selector('h2', text: "Create New Analysis Type") }
        it { should have_content('Name') }
        it { should_not have_content('New Analysis Types cannot be added until at least one Technician is added to the system. Contact the admin to do this.') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
        it { should have_content('Assigned Technicians') }
        it { should have_content(@tech1.fullname) }
        it { should have_content(@tech2.fullname) }
        it { should_not have_content(@res1.fullname) }
      end
      
      describe "providing empty information" do                 
        it "should not create an analysis type" do
          expect{ click_button "Submit" }.to change{AnalysisType.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('3 errors') }
          it { should have_selector('h2', text: "Create New Analysis Type") }
        end
      end

      describe "providing invalid information" do   
        before do
          fill_in 'analysis_type_name'  , with: 'a'*81
          fill_in 'analysis_type_instrument'  , with: 'Dummy Instrument'
          fill_in 'analysis_type_description', with: 'This is a description'   
          find('#technicians').find(:xpath, 'option[2]').select_option           
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
          find('#technicians').find(:xpath, 'option[2]').select_option    
        end
        
        it "should create an analysis type" do
          expect { click_button "Submit" }.to change{AnalysisType.count}.by(1)
        end        
        
        describe "should revert to analysis type view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Analysis Type created!') }
          it { should have_title(full_title('Analysis Type View')) }  
          it { should have_selector('h2', "Analysis Type") }
          it { should_not have_content(@tech1.fullname) }
          it { should have_content(@tech2.fullname) }
        end
      end
  
    end  
    
  end
  
  
  describe "Show page" do
           
    before do 
      @analysis_type = FactoryGirl.build(:analysis_type)
      @analysis_type.technicians << technician
      @analysis_type.save
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
        it { should have_content('Assigned Technicians') }
        it { should have_content(technician.fullname) }
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
        it { should have_content(technician.fullname) }
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
        it { should have_content(technician.fullname) }
        it { should have_link('Options') }
        it { should have_link('Edit Analysis Type') }
        it { should have_link('Delete Analysis Type') }
      end
      
      describe "should navigate to correct edit page on following edit link" do
        before { click_link "Edit Analysis Type" }
        let!(:page_heading) {"Edit Analysis Type " + @analysis_type.id.to_s}
        
        it { should have_content(page_heading) }
      end
      
    end
    
  end

  
  describe "Edit page" do
    
    before do 
      @analysis_type = FactoryGirl.build(:analysis_type)
      @analysis_type.technicians << technician
      @analysis_type.save
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
        @tech1 = FactoryGirl.create(:technician)
        @tech2 = FactoryGirl.create(:technician)
        @res1 = FactoryGirl.create(:researcher)
        @analysis_type.technicians << @tech1
        @analysis_type.technicians << @tech2
        sign_in superuser 
        visit edit_analysis_type_path(@analysis_type)
      end
              
      describe "should be given access to edit analysis type" do
        it { should have_title('HIE Lab Tracker | Edit Analysis Type') }
        it { should have_selector('h2', text: "Edit Analysis Type "+@analysis_type.id.to_s) }
        it { should have_content('Name') }
        it { should have_content('Instrument') }
        it { should have_content('Description') }
        it { should have_content('Assigned Technicians') }
        it { should have_content(@tech1.fullname) }
        it { should have_content(@tech2.fullname) }
        it { should_not have_content(@res1.fullname) }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of analysis types" do
          expect{ click_button "Update" }.to change{AnalysisType.count}.by(0)
        end             
        
        describe "should return to view" do
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

      describe "removing technicians" do   
        before do
          find('#technicians').find(:xpath, 'option[1]').unselect_option  
          find('#technicians').find(:xpath, 'option[2]').unselect_option  
          find('#technicians').find(:xpath, 'option[3]').unselect_option  
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

      describe "providing invalid information" do   
        before do
          fill_in 'analysis_type_name'  , with: 'a'*81
          fill_in 'analysis_type_instrument'  , with: 'Dummy Instrument'
          fill_in 'analysis_type_description', with: 'This is a description'              
          find('#technicians').find(:xpath, 'option[2]').unselect_option  
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
    
  end
  
  
  describe "Analysis Type Deletion" do
    
    before do 
      @analysis_type = FactoryGirl.build(:analysis_type) 
      @analysis_type.technicians << technician
      @analysis_type.save
      sign_in superuser
      visit analysis_type_path(@analysis_type)
    end
    
    it "should delete" do
      expect { click_link "Delete Analysis Type" }.to change(AnalysisType, :count).by(-1)
    end
    
    describe "should revert to analysis type list page with success message and updated info" do
      before { click_link "Delete Analysis Type" }
      it { should have_content('Analysis Type Deleted!') }
      it { should have_content('No Analysis Types found') }
      it { should have_title(full_title('Analysis Types')) }  
      it { should_not have_link('View', :href => analysis_type_path(@analysis_type)) }
    end
  
  end
  
  
end
