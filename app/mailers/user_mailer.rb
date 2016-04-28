class UserMailer < ActionMailer::Base
  default from: "kcheverie@gmail.com"
  def welcome_email(user)
    @user = user
    @url = 'http://www.google.com'
    mail(to: @user.email, subject: 'test welcome email')
  end

  def delete_email(user)
    @user = user
    @url = '/users/new'
    mail(to: @user.email, subject: 'test delete email')
  end
end
