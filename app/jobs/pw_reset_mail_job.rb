class PwResetMailJob < ApplicationJob
  queue_as :default

  def perform(user, email, token)
    user.send_password_reset_email(email, token)
  end
end
