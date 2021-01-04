require 'net/http'
# frozen_string_literal: true

# app/controller/application_controller.rb

# the very base
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :auth_req

  private

  def auth_req
    #   token = request.headers['Authorization']
    #   uri = URI('http://localhost:3001/users/check_token_outside')
    #   # uri = URI('http://localhost:8080/service/users/auth/check_auth_token')
    #   response = Net::HTTP.post(uri, token, 'Content-Type' => 'application/json')
    #   puts response.code.inspect
    #   if response.code != '200'
    #     raise ExceptionHandler::Unauthorized, 'Signature has expired'
    #   else
    #     puts 'donner'
    #   end
  end

end
