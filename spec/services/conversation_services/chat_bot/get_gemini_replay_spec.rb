require "rails_helper"

RSpec.describe ConversationServices::ChatBot::GetGeminiReplay do
  subject(:call_service) { described_class.call(queries: queries) }

  let(:queries) do
    [
      "Some of the tomatoes",
      "Some of the other members of the group"
    ]
  end
  let(:queries_hash) do
    [
      { text: "Some of the tomatoes" },
      { text: "Some of the other members of the group" }
    ]
  end
  let(:gemini_request) do
    instance_double(
      GeminiUtil::GeminiRequest,
      parsed_response_data: gemini_parsed_response
    )
  end
  let(:gemini_parsed_response) { "parsed response" }

  before do
    allow(GeminiUtil::GeminiRequest).to receive(:new).
      with(queries: queries_hash).
      and_return(gemini_request)
    allow(gemini_request).to receive(:call).
      and_return(gemini_request)
  end

  it { is_expected.to eq(gemini_parsed_response) }
end
