class AuthenticationController < ApplicationController

  skip_before_action :auth_req, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    user_id = user.id
    name = user.name
    if !user.avatar.nil?
      if user.avatar.avatar.attached?
        avatar_url = rails_blob_url(user.avatar.avatar)
      else
        avatar_url = Avatar::DEFAULT_AVATAR
      end
    else
      avatar_url = Avatar::DEFAULT_AVATAR
    end
    u = {
        id: user.id,
        name: user.name,
        email: user.email,
        access_token: auth_token,
        avatar: avatar_url
    }
    json_response(user: u)
  end

  private

  def user
    user = AuthenticateUser.new(auth_params[:email], auth_params[:password]).getUser
    return user
  end

  def auth_params
    params.permit(:email, :password)
  end

end
