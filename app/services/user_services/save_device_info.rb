module UserServices
  class SaveDeviceInfo
    def self.call(...)
      new(...).call
    end

    def initialize(user:, params:)
      @user = user
      @params = params

      initialize_user_device
      assign_attributes
    end

    def call
      @user_device.save!
    end

    private

    attr_reader :user, :params, :user_device

    def initialize_user_device
      @user_device = user.device || user.build_device
    end

    def assign_attributes
      @user_device.assign_attributes(
        fcm_token: params[:fcm_token], 
        device_type: params[:device_type]
      )
    end
  end
end