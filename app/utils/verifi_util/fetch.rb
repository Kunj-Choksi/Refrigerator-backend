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
      HashWithIndifferentAccess.new(
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
        client_id: ENV['client_id'],
        client_secret: ENV['client_secret'],
        username: ENV['username'],
        api_key: ENV['api_key']
      )
    end
  end
end
