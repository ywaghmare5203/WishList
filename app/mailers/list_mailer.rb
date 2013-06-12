class ListMailer < ActionMailer::Base
  default :from => "watet@gmail.com"
  def share_list_email(user)
    puts"mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmMMMM#{user[:email].inspect}"
    @user_name = user[:first_name]
#    @pro_id = user[:id]
#    @email  = user.email
#
#    @url = $URL
#    @list_url =$URL
#    @wish_title = wish_title
    mail(:to =>user[:email], :subject => "Your friendwith you")
  end

  def share_contact_email(message, name, subject,email)
    @name = name
    @subject = subject
    @message = message
    @email = email
    mail(:to =>$CONTACT_US_EMAIL ,:subject => subject)
  end
end
