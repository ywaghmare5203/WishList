class UserMailer < ActionMailer::Base
  default :from => "weliike.feedback@gmail.com"


    
  def welcome_email(user)
    @user = user
    @url  = "http:192.168.1.84:3005"
    mail(:to => "ywaghmare5203@gmail.com", :subject => "Welcome to My Awesome Site")
  end
end
