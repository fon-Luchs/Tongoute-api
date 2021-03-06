require 'rails_helper'

RSpec.describe 'DeleteChatResource', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:creator) { create(:user) }

  let(:chat)  { create(:chat, creator_id: creator.id, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  before { create(:user_chat, chat_id: chat.id, user_id: user.id, role: 2) }

  context do
    before { delete '/api/profile/chats/1', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/profile/chats/1', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
