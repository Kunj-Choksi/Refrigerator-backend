module FcmUtil
  class Fcm
    #
    # @example
    #   FcmUtil::Fcm.call(text: text, device_fcm_token: device_fcm_token)
    #
    CREDS = {
      type: ENV.fetch('GC_ACCOUNT_TYPE', nil),
      project_id: ENV.fetch('GC_PROJECT_ID', nil),
      private_key_id: ENV.fetch('GC_PRIVATE_KEY_ID', nil),
      private_key: ENV.fetch('GC_PRIVATE_KEY', nil),
      client_email: ENV.fetch('GC_CLIENT_EMAIL', nil),
      client_id: ENV.fetch('GC_CLIENT_ID', nil),
      auth_uri: ENV.fetch('GC_AUTH_URI', nil),
      token_uri: ENV.fetch('GC_TOKEN_URI', nil),
      auth_provider_x509_cert_url: ENV.fetch('GC_AUTH_PROVIDER_X509_CERT_URL', nil),
      client_x509_cert_url: ENV.fetch('GC_CLIENT_X509_CERT_URL', nil),
      universe_domain: ENV.fetch('GC_UNIVERSE_DOMAIN', nil)
    }.freeze

    def self.call(...)
      new(...).call
    end

    def initialize(text:, device_fcm_token:)
      @text = text
      @device_fcm_token = device_fcm_token

      initialize_fcm
    end

    def call
      fcm.send_v1(message_payload)
    end

    private

    attr_reader :fcm, :text, :device_fcm_token

    def message_payload
      {
        token: device_fcm_token,
        data: {
          payload: {
            data: {
              id: 1
            }
          }.to_json
        },
        notification: {
          title: 'Horrrray',
          body: text
        },
        android: {},
        apns: {
          payload: {
            aps: {
              sound: 'default',
              category: Time.zone.now.to_i.to_s
            }
          }
        },
        fcm_options: {
          analytics_label: 'Label'
        }
      }
    end

    def initialize_fcm
      @initialize_fcm ||= FCM.new(
        nil,
        StringIO.new(JSON.generate(CREDS)),
        'refrigerator-20974'
      )
    end
  end
end
