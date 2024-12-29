class MobileApp::BaseController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :session_user

  def session_user
    decoded_hash = decode_token
    if decoded_hash && decoded_hash.empty?
      render_error_message 'NOT_AUTHORIZED'
      nil
    else
      @user = User.find_by_email(decoded_hash[0]['email'])
    end
  end

  def auth_header
    request.headers['Authorization']
  end

  def decode_token
    return unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256')
    rescue StandardError
      []
    end
  end

  def encoded_token(payload)
    JWT.encode(payload, ENV['SECRET_KEY_BASE'])
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
        return
      end
    end
  end
end
