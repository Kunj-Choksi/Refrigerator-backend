module ConversationServices
  class SaveConversation
    #
    # @example
    #   ConversationServices::SaveConversation.call(user: user, query: query, conversation_id: conversation_id)
    #
    # @param [User] user
    # @param [Query] user query
    # @param [Conversation] Optional. conversation_id
    #
    # @return [Message] last message in conversation
    def self.call(...)
      new(...).call
    end

    def initialize(user:, query:, conversation_id: nil)
      @user = user
      @query = query
      @conversation_id = conversation_id
    end

    def call
      save_user_message
      save_bot_message
    end

    private

    attr_reader :user, :query, :conversation_id

    def conversation
      @conversation ||= begin # rubocop:disable Style/RedundantBegin
        if conversation_id
          user.conversations.find(conversation_id)
        else
          user.conversations.create!(title: conversation_title.strip!)
        end
      end
    end

    def messages
      @messages ||= conversation.messages
    end

    def save_user_message
      messages.create(
        body: query,
        message_type: Message::MESSAGE_TYPE_USER
      )
    end

    def save_bot_message
      messages.create(
        body: ai_bot_response(messages.pluck(:body)),
        message_type: Message::MESSAGE_TYPE_AI_BOT
      )
    end

    def conversation_title
      title_query = ["#{query} - Can you get me SINGLE title to this query?"]
      ai_bot_response(title_query)
    end

    def ai_bot_response(queries)
      # sleep 4
      # 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deserunt cum dignissimos rem cupiditate corporis eius porro ipsam aut unde iure delectus minima atque voluptate ea ad, iusto aperiam similique, blanditiis aspernatur facilis fugiat facere illo? Adipisci ab exercitationem quasi perferendis?'
      ChatBot::GetGeminiReplay.call(queries: queries)
    end
  end
end
