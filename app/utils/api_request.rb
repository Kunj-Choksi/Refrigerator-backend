class ApiRequest
  def call
    run_request
    create_external_request

    self
  end

  def run_request
    @response = HttpWrapper.call(**http_wrapper_params)
  end

  def http_wrapper_params
    { headers:, verb:, url:, body:, json: }
  end

  def success?
    @response.status.success?
  end

  def parsed_response_data
    parsed_response
  end

  def parsed_response
    @response.parsed_response_data
  end

  attr_reader :response

  def headers
    {}
  end

  def verb
    nil
  end

  def url
    nil
  end

  def body
    nil
  end

  def json
    nil
  end

  private

  def create_external_request
    CreateExternalRequest.call(
      reconcilable_id: 123,
      reconcilable_type: 'User',
      url:,
      request_method: verb,
      request_headers: headers,
      request_body: body,
      response_headers: @response.response_headers,
      response_body: @response.raw_response,
      response_code: @response.response_code,
      event: 'page_view',
      duration: 0.5
    )
  end
end
