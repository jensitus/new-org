module ResetToken

  def create_reset_token(token, email)
    u = {
        email: email,
        token: token,
        exp: Time.now
    }
    e = encrypt_and_sign(email)
    e64 = Base64.encode64(email)
    token64 = Base64.urlsafe_encode64(token)
    b64 = Base64.urlsafe_encode64(e)
    u64encrypt_and_sign = encrypt_and_sign(u)
    u64 = Base64.urlsafe_encode64(u64encrypt_and_sign)
    b64
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