class PwResetMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pw_reset_mailer.send_pw_reset_info.subject
  #
  def send_pw_reset_info(email, token)
    @greeting = "Hi"
    @url = "http://localhost:4200/password-reset/" + token + "/edit"
    puts @url.inspect
    mail to: email, subject: "password reset info"
  end
end
