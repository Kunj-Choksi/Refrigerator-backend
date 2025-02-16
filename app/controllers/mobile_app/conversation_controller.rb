class MobileApp::ConversationController < MobileApp::BaseController
  before_action :session_user
  before_action :set_conversation, only: [:conversation_messages]

  def user_conversations
    render_result_json @user.conversations
  end

  def conversation_messages
    return unless has_sufficient_params?(%i[id])

    render_result_json @conversation.messages.order(:created_at).reverse
  end

  def save_conversation_message
    return unless has_sufficient_params?(%i[user_query])

    message = ConversationServices::SaveConversation.call(
      user: @user,
      query: params[:user_query],
      conversation_id: params[:id]
    )

    if message
      render_result_json message
    else
      render_error_message "Couldn't save conversation and Bot did't replied!"
    end
  end

  private

  def set_conversation
    @conversation = @user.conversations.find(params[:id])
  end
end
