class ResetPasswordController < ApplicationController
  include ResetToken
  skip_before_action :auth_req

  def create
    email = create_token_params[:email]
    @user = User.find_by_email(email)
    if @user.nil?
      json_response(Message.email_not_found, :not_found)
    else
      @user.create_reset_digest
      token = create_reset_token(@user.reset_token, email)
      PwResetMailJob.perform_later(@user, email, token)
      json_response(Message.reset_instructions_sent, :ok)
    end
  end

  def check_token
    u = check_reset_token(reset_params[:token])
    if u
      json_response(Message.perfect, :ok)
    else
      json_response(Message.signature_expired, :forbidden)
    end
  end

  def reset_password
    u = check_reset_token(reset_params[:token])
    if u
      if reset_params[:password].eql?(reset_params[:password_confirmation])
        user = User.find_by_email(u[:email])
        user.update(password: reset_params[:password])
        json_response(Message.pw_changed, :ok)
      else
        json_response(Message.pw_confirmation_not_match, :not_acceptable)
      end
    else
      json_response(Message.alles_geht_schief, :forbidden)
    end
  end

  private

  def create_token_params
    params.permit(:email)
  end

  def check_token_params
    params.permit(:token)
  end

  def reset_params
    params.permit(:token, :password, :password_confirmation)
  end

end
