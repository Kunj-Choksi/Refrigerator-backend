class MobileApp::SessionController < MobileApp::BaseController
  def login
    return unless has_sufficient_params?(%i[email password])

    @user = User.find_by(email: params[:email])

    if @user.nil?
      render_error_message "User not found"
      return
    end

    if @user.authenticate(params[:password])
      render_result_json token
    else
      render_error_message "Password is incorrect"
      nil
    end
  end

  private

  def token
    payload = {
      email: params[:email],
      password: params[:password]
    }
    encoded_token(payload)
  end
end
