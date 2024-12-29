class MobileApp::ConversationController < MobileApp::BaseController
  before_action :set_conversation, only: [:conversation_messages]

  def user_conversations
    render_result_json @user.conversations
  end

  def conversation_messages
    return unless has_sufficient_params?(%w[id])

    render_result_json @conversation.messages.order(:created_at).reverse
  end

  def save_conversation_message
    return unless has_sufficient_params?(%w[id user_query])

    query_replay = ConversationServices::SaveConversation.call(user: @user, query: params[:user_query],
                                                               conversation_id: params[:id])

    if query_replay
      render_result_json query_replay
    else
      render_error_message "Couldn't save conversation and Bot did't replied!"
    end
  end

  private

  def set_conversation
    @conversation = @user.conversations.find(params[:id])
  end
end
