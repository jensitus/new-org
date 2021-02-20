class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :delete, :upload_avatar]
  skip_before_action :auth_req, only: [:create]

  def index
    @users = User.all
    json_response(@users, :ok)
  end

  def show
    ur_org_user = UrOrgUser.find_by_user_id(@user.id)
    if ur_org_user.avatar.attached?
      avatar_url = rails_blob_path(ur_org_user.avatar)
    end
    u = {
        id: ur_org_user.user_id,
        name: ur_org_user.name,
        email: ur_org_user.email,
        avatar: avatar_url
    }
    json_response(u,:ok)
  end

  def create
    if user_params[:password_confirmation].nil?
      response = {message: Message.pw_confirmation_can_not_be_blank}
      return json_response(response, :unprocessable_entity)
    end
    user_params[:email] = user_params[:email].downcase!
    user = User.create!(user_params)
    if user
      uou = UrOrgUser.create!(user_id: user.id, name: user.name, email: user.email)
      uou.avatar.attach(
          io: File.open('public/img/grav.png'),
          filename: 'grav.png',
          content_type: 'image/png',
          identify: false
      )
    end
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = {message: Message.account_created, auth_token: auth_token}
    json_response(response, :created)
  end

  def update
  end

  def delete
  end

  def upload_avatar
    ur_org_user = UrOrgUser.find_by_user_id(@user.id)
    ur_org_user.avatar.attach(params[:avatar])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
