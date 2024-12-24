module ConversationServices
  module ChatBot
    class GeminiService
      #
      # @example
      #   ConversationServices::ChatBot::GeminiService.call(query: query)
      def self.call(...)
        new(...).call
      end

      def initialize(query:)
        @query = query
      end

      def call
        gemini_request_klass.call.parsed_response_data
      end

      private

      attr_reader :query

      def gemini_request_klass
        GeminiUtil::GeminiRequest.new(query:)
      end
    end
  end
end
