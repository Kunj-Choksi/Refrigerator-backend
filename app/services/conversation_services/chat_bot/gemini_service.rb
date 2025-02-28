module ConversationServices
  module ChatBot
    class GeminiService
      #
      # @example
      #   ConversationServices::ChatBot::GeminiService.call(queries: queries)
      def self.call(...)
        new(...).call
      end

      def initialize(queries:)
        @queries = queries
      end

      def call
        gemini_request_klass.call.parsed_response_data
      end

      private

      attr_reader :queries

      def gemini_request_klass
        GeminiUtil::GeminiRequest.new(queries: request_queries)
      end

      def request_queries
        queries.map do |query|
          { text: query }
        end
      end
    end
  end
end
