module FcmUtil
  class Fcm
    #
    # @example
    #   FcmUtil::Fcm.call(text: text, device_fcm_token: device_fcm_token)
    #
    CREDS = {
      "type": ENV['GC_ACCOUNT_TYPE'],
      "project_id": ENV['GC_PROJECT_ID'],
      "private_key_id": ENV['GC_PRIVATE_KEY_ID'],
      "private_key": ENV['GC_PRIVATE_KEY'],
      "client_email": ENV['GC_CLIENT_EMAIL'],
      "client_id": ENV['GC_CLIENT_ID'],
      "auth_uri": ENV['GC_AUTH_URI'],
      "token_uri": ENV['GC_TOKEN_URI'],
      "auth_provider_x509_cert_url": ENV['GC_AUTH_PROVIDER_X509_CERT_URL'],
      "client_x509_cert_url": ENV['GC_CLIENT_X509_CERT_URL'],
      "universe_domain": ENV['GC_UNIVERSE_DOMAIN']
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
        'token': device_fcm_token,
        'data': {
          payload: {
            data: {
              id: 1
            }
          }.to_json
        },
        'notification': {
          title: 'Horrrray',
          body: text
        },
        'android': {},
        'apns': {
          payload: {
            aps: {
              sound: 'default',
              category: "#{Time.zone.now.to_i}"
            }
          }
        },
        'fcm_options': {
          analytics_label: 'Label'
        }
      }
    end

    def initialize_fcm
      @fcm ||= FCM.new(
        nil,
        # './tmp/creds.json',
        StringIO.new(JSON.generate(CREDS)),
        'refrigerator-20974'
      )
    end
  end
end
