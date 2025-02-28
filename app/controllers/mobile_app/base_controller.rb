class MobileApp::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  def session_user
    return true if user.present?

    render_error_message "NOT_AUTHORIZED"
    false
  end

  def render_result_json(object)
    obj = {
      status: "success",
      contents: object
    }
    render json: obj
  end

  def render_result_message(message)
    obj = {
      status: "success",
      message: message
    }
    render json: obj
  end

  def render_error_message(message)
    obj = {
      status: "error",
      message: message
    }
    render json: obj
  end

  def has_sufficient_params?(mandatory_params)
    mandatory_params.each do |key|
      if params[key].blank?
        render_error_message("Missing required parameter #{key}")
        break
      end
    end
  end

  private

  def user
    return nil if decode_token.empty?

    @user ||= User.find_by(email: decode_token.first&.dig("email"))
  end

  def decode_token
    return [] unless auth_header

    token = auth_header.split.second

    @decode_token ||= begin
      JWT.decode(token, ENV.fetch("SECRET_KEY_BASE", nil), true, algorithm: "HS256")
    rescue StandardError
      []
    end
  end

  def auth_header
    request.headers["Authorization"]
  end

  def encoded_token(payload)
    JWT.encode(payload, ENV.fetch("SECRET_KEY_BASE", nil))
  end
end
