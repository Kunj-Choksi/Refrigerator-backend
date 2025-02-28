module VerifiUtil
  class Fetch
    def self.call(...)
      new(...).call
    end

    def call
      veryfi_client.document.process_url(params)
    end

    private

    def initialize(file_path)
      @file_path = file_path
    end

    attr_reader :file_path

    def params
      ActiveSupport::HashWithIndifferentAccess.new(
        file_url: @file_path,
        auto_delete: true,
        boost_mode: false,
        async: false,
        external_id: '123456789',
        max_pages_to_process: 10,
        tags: ['tag1'],
        categories: [
          'Advertising & Marketing',
          'Automotive'
        ]
      )
    end

    def veryfi_client
      Veryfi::Client.new(
        client_id: ENV.fetch('VERIFY_CLIENT_ID', nil),
        client_secret: ENV.fetch('VERIFY_CLIENT_SECRET', nil),
        username: ENV.fetch('VERIFY_USERNAME', nil),
        api_key: ENV.fetch('VERIFY_API_KEY', nil)
      )
    end
  end
end
