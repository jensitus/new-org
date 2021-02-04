class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :delete, :upload_avatar]
  skip_before_action :auth_req, only: [:create]

  def index
    @users = User.all
    json_response(@users, :ok)
  end

  def show
    json_response(@user, :ok)
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
  end

  def delete
  end

  def upload_avatar
    @user.avatar.attach(params[:avatar])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
