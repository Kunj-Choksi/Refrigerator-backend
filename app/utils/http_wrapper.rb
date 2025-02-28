class HttpWrapper
  def self.call(...)
    new(...).call
  end

  def initialize(headers:, verb:, url:, body: nil, json: nil)
    @headers = headers
    @verb = verb
    @url = url
    @body = body
    @json = json
  end

  def call
    request = HTTP.headers(headers)
    @response = request.send(verb, url, options)
    self
  rescue HTTP::Error => e
    raise StandardError, e.message
  end

  def parsed_response_data
    case response.mime_type
    when %r{application/.*json}
      raw_response.blank? ? {} : JSON.parse(raw_response)
    else
      raw_response
    end
  end

  delegate :code, to: :response, prefix: true

  delegate :headers, to: :response, prefix: true

  def raw_response
    response.to_s
  end

  private

  attr_reader :body, :headers, :json, :verb, :url, :response

  def options
    { body:, json: }.compact
  end

  def mime_type
    response.mime_type
  end
end
