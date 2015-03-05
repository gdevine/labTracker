require 'rails_helper'

RSpec.describe "Menu Panel - ", type: :feature do

  subject { page }
  
  let(:user)            { FactoryGirl.create(:user) }
  let(:unapproved_user) { FactoryGirl.create(:unapproved_user) }
  let(:researcher)      { FactoryGirl.create(:researcher) }
  let(:technician)      { FactoryGirl.create(:technician) }
  let(:superuser)       { FactoryGirl.create(:superuser) }
  
  # Checking that the menu bar appears when it's supposed to
  describe "Home page" do
    
    describe "for non signed-in users" do
      before { visit root_path }
      it 'should not have a nav#minibar bar' do
        expect(page).not_to have_selector('nav#minibar')
      end
    end
    
    describe "for signed-in researchers" do
      before do 
        sign_in(researcher) 
        visit root_path
      end
        
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end
    
    describe "for unapproved users" do
      before do 
        sign_in(unapproved_user) 
        visit root_path
      end
      
      it 'should not have a nav#minibar bar' do
        expect(page).not_to have_selector('nav#minibar')
      end
    end

    describe "for signed-in researchers" do
      before do 
        sign_in(researcher) 
        visit root_path
      end
        
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end

    describe "for signed-in technicians" do
      before do 
        sign_in(technician) 
        visit root_path
      end
        
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end
 
    describe "for signed-in superusers" do
      before do 
        sign_in(superuser) 
        visit root_path
      end
        
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end
    
    describe "for superusers who've been marked unapproved" do
      before do 
        superuser.approved = false
        superuser.save
        sign_in(superuser) 
        visit root_path
      end
        
      it 'should not have a nav#minibar bar' do
        expect(page).not_to have_selector('nav#minibar')
      end
    end
        
  end
  
  # The menu bar should appear on the standard static pages: contact page, about page etc if logged in
  describe "Help page" do
    describe "for signed-in researchers" do
      before do 
        sign_in(researcher)
        visit help_path
      end
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end
    
  end
  
  
  # The menu bar should not appear on sign-in or register error pages
  describe "Sign in error page" do
    before { visit new_user_session_path }
    it 'should not have a nav#minibar bar' do
      expect(page).not_to have_selector('nav#minibar')
    end
  end
  
  describe "Register error page" do
    before { visit new_user_registration_path }

    it 'should not have a nav#minibar bar' do
      expect(page).not_to have_selector('nav#minibar')
    end
  end
  
  # # Dashboard Link
  # describe "Visitng the home page" do
    # describe "when signed in" do
      # before do
        # sign_in(user)
        # visit root_path
      # end
      # it "should show a link for Dashboard" do
        # expect(page).to have_link('dashboard_link')
      # end
#       
      # describe "and clicking the Dashboard link" do
        # before do
          # click_link('dashboard_link')
        # end
#     
        # it "should open up the Dashboard page" do
          # expect(page).to have_title('Dashboard')
          # expect(page).to have_content('Instrument Tracker Dashboard')
        # end
      # end
#       
    # end
#     
    # describe "when not signed in" do
      # before do 
        # visit root_path
      # end
      # it "should show a link for Dashboard" do
        # expect(page).to have_link('dashboard_link')
      # end
    # end
#     
# 
  # end 
    

  # Analysis Type dropdown   
  describe "Opening the Analysis Types dropdown" do
  
    describe "when not signed in" do
      before { visit root_path }
      it 'should not be possible' do
        expect(page).not_to have_link('Analysis Types')
        expect(page).not_to have_link('analysis_types_index')
      end
    end

    describe "when signed in as a researcher" do
      before do 
        sign_in(researcher) 
        visit root_path
      end
      
      it "should show a main link for 'Analysis Types'" do
        expect(page).to have_link('Analysis Types')
      end
      it "should show a link for 'View All' Analysis Types" do
        expect(page).to have_link('analysis_types_index')
      end
      it "should not show a link for 'Add New' Analysis Type" do
        expect(page).not_to have_link('analysis_types_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('analysis_types_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Available Analysis Types')
        end
      end
    end
    
    describe "when signed in as a technician" do
      before do 
        sign_in(technician) 
        visit root_path
      end
      
      it "should show a main link for 'Analysis Types'" do
        expect(page).to have_link('Analysis Types')
      end
      it "should show a link for 'View All' Analysis Types" do
        expect(page).to have_link('analysis_types_index')
      end
      it "should not show a link for 'Add New' Analysis Type" do
        expect(page).not_to have_link('analysis_types_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('analysis_types_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Available Analysis Types')
        end
      end
    end
    
    describe "when signed in as a superuser" do
      before do 
        sign_in(superuser) 
        visit root_path
      end
      
      it "should show a main link for 'Analysis Types'" do
        expect(page).to have_link('Analysis Types')
      end
      it "should show a link for 'View All' Analysis Types" do
        expect(page).to have_link('analysis_types_index')
      end
      it "should show a link for 'Add New' Analysis Type" do
        expect(page).to have_link('analysis_types_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('analysis_types_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Available Analysis Types')
        end
      end
      
      describe "and clicking the Create New link" do
        before do
          click_link('analysis_types_new')
        end
    
        it "should open up the Create New page" do
          expect(page).to have_title('New Analysis Type')
          expect(page).to have_selector('h2', text: "New Analysis Type")
        end
      end
      
    end
    
    
#       
      # describe "and clicking the View Lost Instruments link" do
        # before do
          # click_link('losts_index')
        # end
#     
        # it "should open up the View current losts page" do
          # expect(page).to have_title('Lost List')
        # end
      # end
#       
      # describe "and clicking the View In Storage link" do
        # before do
          # click_link('storages_index')
        # end
#     
        # it "should open up the View current storages page" do
          # expect(page).to have_title('In Storage List')
        # end
      # end
#       
      # describe "and clicking the View Face Deployment link" do
        # before do
          # click_link('facedeployments_index')
        # end
#     
        # it "should open up the View current face deployments page" do
          # expect(page).to have_title('FACE Deployment List')
        # end
      # end
#       
      # describe "and clicking the View Retired link" do
        # before do
          # click_link('retirements_index')
        # end
#     
        # it "should open up the View current retirements page" do
          # expect(page).to have_title('Retired List')
        # end
      # end
#       
      # describe "and clicking the Create New link" do
        # before do
          # FactoryGirl.create(:model)
          # click_link('instruments_new')
        # end
#     
        # it "should open up the Create Instrument page" do
          # expect(page).to have_title('New Instrument')
        # end
      # end
    
   
  end
#   
#   
# # Resources menu
#   
  # describe "opening the resources dropdown" do
    # before { sign_in(user) }
    # before { visit root_path }
#     
    # describe "and clicking the models link" do
      # before do
        # click_link('Models')
      # end
#   
      # it "should open up the models index page" do
        # expect(page).to have_title('Models List')
      # end
    # end
  # end
  

end
