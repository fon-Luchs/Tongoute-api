require 'rails_helper'

RSpec.describe 'PostConversation', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let(:recipient) { create(:user) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    []
  end

  before { build(:conversation, sender_id: user.id, recipient_id: recipient.id) }

  let(:conversation) { Conversation.last }

  context do
    before { get '/api/profile/conversations', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/conversations', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
