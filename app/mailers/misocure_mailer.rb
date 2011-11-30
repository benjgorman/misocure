class MisocureMailer < ActionMailer::Base
  default from: "misocure@benjgorman.com"
  
  def welcome_email(user)
    @user = user
    mail(:to => user.email,
    :subject => "Welcome to Misocure! - One last step!")
  end
end
