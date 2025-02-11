class MobileApp::BaseController < ActionController::Base
  protect_from_forgery with: :null_session

  def session_user
    return if user

    render_error_message 'NOT_AUTHORIZED'
    nil
  end

  def render_result_json(object)
    obj = {
      status: 'success',
      contents: object
    }
    render json: obj
  end

  def render_result_message(message)
    obj = {
      status: 'success',
      message:
    }
    render json: obj
  end

  def render_error_message(message)
    obj = {
      status: 'error',
      message:
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
    return false if decode_token.empty?

    @user ||= User.find_by(email: decode_token.first&.dig('email'))
  end

  def auth_header
    request.headers['Authorization']
  end

  def decode_token
    return false unless auth_header

    token = auth_header.split(' ').second

    @decode_token ||= begin
      JWT.decode(token, ENV.fetch('SECRET_KEY_BASE', nil), true, algorithm: 'HS256')
    rescue StandardError
      []
    end
  end

  def encoded_token(payload)
    JWT.encode(payload, ENV.fetch('SECRET_KEY_BASE', nil))
  end
end
