module ControllerHelpers
  def admin_sign_id(admin)
    allow(controller).to receive(:current_admin)
      .and_return(admin)
    expect(controller).to receive(:authenticate_admin!)
  end

  def build_parameters(attributes = {}, permit = true)
    parameters = ActionController::Parameters.new(attributes)

    if permit
      parameters.permit!
    else
      parameters.each do |k, v|
        next unless v.is_a?(Hash)

        parameters[k] = build_parameters(v, false)
      end
    end
    parameters
  end

  def build_permitted_parameters(params, params_method)
    permitted_keys = controller.send(params_method)
    build_parameters(params)
      .permit(*permitted_keys)
      .permit!
  end
end
