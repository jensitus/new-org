class AuthenticationController < ApplicationController

  skip_before_action :auth_req, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    u = {
        id: user.id,
        name: user.name,
        email: user.email,
        access_token: auth_token
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
