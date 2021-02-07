class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include EncryptionService

  before_action :auth_req

  attr_reader :current_user

  private

  def auth_req
    @current_user = (AuthorizeApiRequest.new(request.headers).call[:user])
  end

end
