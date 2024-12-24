# Saves the External Request
#
# @example
#   CreateExternalRequest.call(
#     reconcilable_id: 123,
#     reconcilable_type: 'User',
#     url: 'https://example.com',
#     request_method: 'GET',
#     request_headers: '{"Content-Type": "application/json}
#     request_body: '{}'
#     response_headers: { 'Content-Type' => 'application/json' },
#     response_body: '{"status": "success"}',
#     response_code: 200,
#     event: 'page_view',
#     duration: 0.5,
#   )
#
# @param reconcilable_id [Integer, nil] The reconcilable ID.
# @param reconcilable_type [String, nil] The reconcilable type.
# @param url [String] The URL of the external request.
# @param request_method [String] The type of the HTTP request.
# @param response_body [String] The body of the response.
# @param response_code [Integer] The HTTP response code.
# @param event [String] The event type.
# @param response_headers [Hash] The headers of the response.
# @param duration [Integer]
# @param request_body [String] The body of the request.
#
# @return [Boolean] Saved External Request
class CreateExternalRequest
  def self.call(...)
    new(...).call
  end

  def initialize(
    url:,
    request_method:,
    response_body:,
    response_code:,
    response_headers:,
    event:,
    duration:,
    reconcilable_id: nil,
    reconcilable_type: nil,
    request_body: nil,
    request_headers: nil
  )
    @url = url
    @request_method = request_method
    @response_body = response_body
    @response_code = response_code
    @event = event
    @response_headers = response_headers
    @duration = duration
    @reconcilable_id = reconcilable_id
    @reconcilable_type = reconcilable_type
    @request_body = request_body
    @request_headers = request_headers

    assign_attributes
  end

  def call
    external_request.save!
  end

  private

  attr_reader :external_request, :url, :request_method, :response_body, :response_code, :event, :response_headers, :duration,
              :reconcilable_id, :reconcilable_type, :request_body, :request_headers

  def assign_attributes
    @external_request = ExternalRequest.new(
      reconcilable_id:,
      reconcilable_type:,
      url:,
      request_method:,
      request_headers:,
      request_body:,
      response_code:,
      response_headers:,
      response_body:,
      event:,
      duration:
    )
  end
end
