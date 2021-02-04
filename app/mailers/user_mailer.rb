class UserMailer < ApplicationMailer

  def account_activation
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def password_reset(user, reset_token)
    @reset_token = reset_token
    @greeting = "Hi " + user.name
    @user = user
    mail to: user.email, subject: 'Password reset'
  end

end
