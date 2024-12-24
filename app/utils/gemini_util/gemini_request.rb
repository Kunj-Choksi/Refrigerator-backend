module GeminiUtil
  # Gemini Request to get generative content
  class GeminiRequest < ApiRequest
    # @params [String] query
    def initialize(query:)
      @query = query
    end

    def parsed_response_data
      parsed_response['candidates'].first.dig('content', 'parts').first['text']
    end

    private

    attr_reader :query

    def verb
      :post
    end

    def header
      {
        'Content-Type': 'application/json'
      }
    end

    def url
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=#{ENV['GEMINI_KEY']}"
    end

    def json
      {
        contents: [{
          parts: [
            {
              text: query
            }
          ]
        }]
      }
    end
  end
end
