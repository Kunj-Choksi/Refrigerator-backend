require "rails_helper"

RSpec.describe ConversationServices::SaveConversation do
  subject(:call_service) do
    described_class.call(
      user: user,
      query: query,
      conversation_id: conversation_id
    )
  end

  let(:user) do
    instance_double(
      User,
      conversations: conversations
    )
  end
  let(:query) { "I've foo bar. Can you generate baz foo for me?" }
  let(:queries) { [query] }
  let(:conversation_id) { 1 }
  let(:conversations) { double(ActiveRecord::Relation) }
  let(:conversation) { Conversation.new }
  let(:messages) { double(ActiveRecord::Relation) }
  let(:bot_replay) { "some replay" }
  let(:bot_replay_message) { double(Message) }

  before do
    allow(conversations).to receive(:find).
      with(conversation_id).
      and_return(conversation)
    allow(conversation).to receive(:messages).
      and_return(messages)
    allow(messages).to receive(:create).
      with(
        body: query,
        message_type: Message::MESSAGE_TYPE_USER
      )
    allow(messages).to receive(:pluck).
      with(:body).
      and_return(queries)
    allow(ConversationServices::ChatBot::GetGeminiReplay).to receive(:call).
      with(queries: queries).
      and_return(bot_replay)
    allow(messages).to receive(:create).
      with(
        body: bot_replay,
        message_type: Message::MESSAGE_TYPE_AI_BOT
      ).
      and_return(bot_replay_message)
  end

  it { is_expected.to eq(bot_replay_message) }

  context "with new conversation" do
    let(:conversation_id) { nil }
    let(:bot_title) { "le foo bar title" }
    let(:title_queries) do
      ["#{query} - Can you get me SINGLE title to this query?"]
    end

    before do
      allow(ConversationServices::ChatBot::GetGeminiReplay).to receive(:call).
        with(queries: title_queries).
        and_return(bot_title)
      # FIXME:
      allow(bot_title).to receive(:strip!).
        and_return(bot_title)
      allow(conversations).to receive(:create!).
        with(title: bot_title).
        and_return(conversation)
    end

    it { is_expected.to eq(bot_replay_message) }
  end
end
