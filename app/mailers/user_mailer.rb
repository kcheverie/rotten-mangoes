class UserMailer < ActionMailer::Base

  default from: "accounts@rottenmangoes.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Rotten Mangoes')
  end

  def delete_email(user)
    @user = user
    @url = '/users/new'
    mail(to: @user.email, subject: 'Account Deletion Notice')
  end
end
