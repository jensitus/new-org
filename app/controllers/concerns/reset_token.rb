module ResetToken

  def create_reset_token(token, email)
    u = {
        token: token,
        exp: Time.now,
        email: email
    }

    Base64.urlsafe_encode64(encrypt_and_sign(u))
  end

  def check_reset_token(token)
    u = decrypt_and_verify(Base64.urlsafe_decode64(token))
    @user = User.find_by_email(u[:email])
    if @user.check_token_valid(u[:token])
      if u[:exp] > 20.minutes.ago
        u
      else
        false
      end
    end

  end

end