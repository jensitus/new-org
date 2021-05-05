class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :delete, :upload_avatar]
  skip_before_action :auth_req, only: [:create]

  def index
    @users = User.all
    json_response(@users, :ok)
  end

  def show
    if !@user.avatar.nil?
      if @user.avatar.avatar.attached?
        avatar_url = rails_blob_url(@user.avatar.avatar)
      else
        avatar_url = Avatar::DEFAULT_AVATAR
      end
    else
      avatar_url = Avatar::DEFAULT_AVATAR
    end
    u = {
        id: @user.id,
        name: @user.name,
        email: @user.email,
        avatar: avatar_url
    }
    json_response(u, :ok)
  end

  def create
    if user_params[:password_confirmation].nil?
      response = {message: Message.pw_confirmation_can_not_be_blank}
      return json_response(response, :unprocessable_entity)
    end
    user_params[:email] = user_params[:email].downcase!
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = {message: Message.account_created, auth_token: auth_token}
    json_response(response, :created)
  end

  def update
    user = User.find(update_params[:id])
    if user.update(name: update_params[:name], email: update_params[:email])
      ur_org_user = UrOrgUser.find_by(user_id: user.id)
      ur_org_user.update(name: user.name, email: user.email)
    end
    json_response(ur_org_user, :ok)
  end

  def delete
  end

  def upload_avatar
    a = @user.avatar
    if a.nil?
      a = Avatar.create!(user_id: @user.id)
    end
    a.avatar.attach(avatar_params[:avatar])
    @user = User.find(@user.id)
    u = {
        id: @user.id,
        name: @user.name,
        email: @user.email,
        avatar: rails_blob_url(@user.avatar.avatar)
    }
    puts u.inspect
    json_response(u, :ok)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:id, :name, :email, :avatar, :password)
  end

  def avatar_params
    params.permit(:avatar)
  end

end
