module ExceptionHandler
  extend ActiveSupport::Concern

  class InvalidToken < StandardError; end
  class Unauthorized < StandardError; end
  class MissingToken < StandardError; end
  class AuthenticationError < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ExceptionHandler::Unauthorized do |e|
      json_response({ message: e.message }, :unauthorized)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordNotUnique do |e|
      puts '+++++++++++++++++++'
      puts e.to_s.split(':').inspect
      puts '+++++++++++++++++++'
      json_response({message: e.to_s.split(':').last}, :unprocessable_entity)
    end

    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::InvalidToken do |e|
      puts e.message.inspect
      json_response({message: e.message}, :unauthorized)
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({message: e.message}, :unprocessable_entity)
  end

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end

end