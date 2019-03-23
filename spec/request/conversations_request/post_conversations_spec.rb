require 'rails_helper'

RSpec.describe 'PostConversation', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let(:recipient) { create(:user, id: 4) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:interlocutor) do
    {
      'id' => recipient.id,
      'name' => "#{recipient.first_name} #{recipient.last_name}",
      'type' => recipient.class.name 
    }
  end

  let(:resource_response) do
    {
      'id' => conversation.id,
      'interlocutor' => interlocutor,
      'messages' => []

    }
  end

  before { build(:conversation, senderable: user, recipientable: recipient) }

  let(:conversation) { Conversation.last }

  context do
    before { post '/api/users/4/conversations', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/4/conversations', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
