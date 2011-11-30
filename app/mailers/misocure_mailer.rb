class MisocureMailer < ActionMailer::Base
  default from: "misocure@benjgorman.com"
  
  def welcome_email(user)
    @user = user
    mail(:to => user.email,
    :subject => "SUP FOOO")
  end
end
