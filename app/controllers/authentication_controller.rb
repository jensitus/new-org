class AuthenticationController < ApplicationController

  skip_before_action :auth_req, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    user_id = user.id
    name = user.name
    ur_org_user = UrOrgUser.find_by_user_id(user.id)
    if ur_org_user.avatar.attached?
      avatar_url = rails_blob_url(ur_org_user.avatar)
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
