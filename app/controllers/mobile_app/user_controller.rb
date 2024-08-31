class MobileApp::UserController < MobileApp::BaseController
  def save_device_info
    return unless has_sufficient_params?(%w[fcm_token device_type])

    if UserServices::SaveDeviceInfo.call(user: @user, params: params)
      render_result_message "Saved device information"
    else
      render_error_message "Not saved device information"
    end
  end
end
