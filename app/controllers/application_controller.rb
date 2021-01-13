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
      token = request.headers['Authorization']
      uri = URI('http://localhost:3001/api/auth/users/check_token_outside')
      # uri = URI('http://localhost:8080/service/users/auth/check_auth_token')
      response = Net::HTTP.post(uri, { 'access_token' => token }.to_json, 'Content-Type' => 'application/json')
      puts response.body
      @current_user_id = response.body
      if response.code != '200'
        raise ExceptionHandler::Unauthorized, 'Signature has expired'
      else
        puts 'yeah, 200!'
      end
  end

end
