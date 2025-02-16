class MobileApp::UserController < MobileApp::BaseController
  before_action :session_user

  def save_device_info
    return unless has_sufficient_params?(%i[fcm_token device_type])

    if UserServices::SaveDeviceInfo.call(user: @user, params: params)
      render_result_message "Saved device information"
    else
      render_error_message "Error while saving device information"
    end
  end
end
