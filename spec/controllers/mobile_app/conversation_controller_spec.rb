require "rails_helper"

RSpec.describe MobileApp::ConversationController do
  let(:params) { double("params") }

  describe "GET #user_conversations" do
    let(:conversations) { double("conversations") }
    let(:call_api_request) { get :user_conversations, xhr: true }
    let(:response) do
      { json: { status: 'success', contents: conversations } }
    end

    before do
      allow(user).to receive(:conversations).
        and_return(conversations)
    end

    it_behaves_like 'mobile app api request'
  end

  describe "GET #conversation_messages" do
    let(:params) { { id: '1' } }
    let(:conversation) { double("conversation") }
    let(:messages) { double('messages') }

    let(:call_api_request) { get :conversation_messages, params: params, xhr: true }
    let(:response) do
      { json: { status: 'success', contents: messages } }
    end

    before do
      allow(user).to receive_message_chain(:conversations, :find).
        with(params[:id]).
        and_return(conversation)
      allow(conversation).to receive_message_chain(:messages, :order).
        with(:created_at).
        and_return(messages)
      allow(messages).to receive(:reverse).
        and_return(messages)
    end

    it_behaves_like "mobile app api request"
  end

  describe "POST #save_conversation_message" do
    let(:params) do
      {
        user_query: "user query",
        id: conversation_id
      }
    end
    let(:conversation_id) { '1' }
    let(:message) { double('message') }
    let(:user_query) { "user query" }

    let(:call_api_request) do
      post :save_conversation_message, params: params, xhr: true
    end
    let(:response) do
      { json: { status: 'success', contents: message } }
    end

    before do
      allow(ConversationServices::SaveConversation).to receive(:call).
        with(
          user: user,
          query: user_query,
          conversation_id: conversation_id
        ).
        and_return(message)
    end

    it_behaves_like "mobile app api request"

    context "without conversation id" do
      let(:conversation_id) { nil }

      it_behaves_like "mobile app api request"
    end

    context "when it fails while saving conversation" do
      let(:message) { nil }
      let(:response) do
        { json: { status: 'error', message: "Couldn't save conversation and Bot did't replied!" } }
      end

      it_behaves_like "mobile app api request"
    end
  end
end
