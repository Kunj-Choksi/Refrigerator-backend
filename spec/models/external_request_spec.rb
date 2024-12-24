# == Schema Information
#
# Table name: external_requests
#
#  id                :bigint           not null, primary key
#  duration          :decimal(10, 3)
#  event             :string
#  reconcilable_type :string
#  request_body      :string
#  request_headers   :string
#  request_method    :string
#  response_body     :string
#  response_code     :string
#  response_headers  :string
#  url               :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reconcilable_id   :integer
#
require 'rails_helper'

RSpec.describe ExternalRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
