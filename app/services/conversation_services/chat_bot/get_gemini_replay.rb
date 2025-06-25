module ConversationServices
  module ChatBot
    class GetGeminiReplay
      #
      # @example
      #   ConversationServices::ChatBot::GetGeminiReplay.call(queries: queries)
      def self.call(queries:)
        GeminiUtil::GeminiRequest.
          new(
            queries: queries.map { |query| { text: query } }
          ).
          call.
          parsed_response_data
      end
    end
  end
end
