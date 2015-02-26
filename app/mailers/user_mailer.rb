class UserMailer < ActionMailer::Base
  default from: 'notifications@hie-labtracker.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://hie-labtracker@uws.edu.au'
    mail(to: @user.email, subject: 'Welcome to HIE Lab Tracker')
  end
  
  def new_user_waiting_for_approval(user)
    mail(to: 'g.devine@uws.edu.au', subject: 'HIE Lab Tracker Registration Request')
  end
  
end
