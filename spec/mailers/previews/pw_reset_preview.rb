# Preview all emails at http://localhost:3000/rails/mailers/pw_reset
class PwResetPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/pw_reset/send_pw_reset_info
  def send_pw_reset_info
    PwResetMailer.send_pw_reset_info
  end

end
