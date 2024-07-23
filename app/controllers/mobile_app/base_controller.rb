class MobileApp::BaseController < ActionController::Base
  protect_from_forgery with: :null_session
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
