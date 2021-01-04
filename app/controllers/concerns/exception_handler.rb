module ExceptionHandler
  extend ActiveSupport::Concern

  class InvalidToken < StandardError; end
  class Unauthorized < StandardError; end

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
  end
end