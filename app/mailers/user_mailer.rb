class UserMailer < ActionMailer::Base
  default from: "kcheverie@gmail.com"
  def welcome_email(user)
    @user = user
    @url = 'http://www.google.com'
    mail(to: @user.email, subject: 'test welcome email')
  end
end
