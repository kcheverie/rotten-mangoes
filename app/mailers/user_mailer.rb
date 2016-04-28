class UserMailer < ActionMailer::Base
  default from: "accounts@rottenmangoes.com"

  def delete_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email,
         subject: 'Welcome to My Awesome Site',
         template_path: 'notifications',
         template_name: 'another')
  end

end
