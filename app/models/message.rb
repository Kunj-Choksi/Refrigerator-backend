# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  body            :text
#  message_type    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint           not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#
class Message < ApplicationRecord
  belongs_to :conversation

  MESSAGE_TYPE_USER = 'user'.freeze
  MESSAGE_TYPE_AI_BOT = 'bot'.freeze
end
