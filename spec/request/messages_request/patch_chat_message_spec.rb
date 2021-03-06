require 'rails_helper'

RSpec.describe 'PatchChatMessage', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let(:recipient) { create(:user) }

  let!(:chat) { create(:chat, creator_id: user.id, id: 1) }

  let!(:message) { create(:message, user_id: user.id, id: 1,
                                    messageable_id: chat.id,
                                    messageable_type: chat.class.name ) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { message: resource_params } }

  let(:resource_params) { attributes_for(:message) }

  let(:author) do
    {
      'id' => user.id,
      'name' => "#{user.first_name} #{user.last_name}"
    }
  end

  let(:resource_response) do
    {
      'id' => 1,
      'text' => Message.last.text,
      'author' => author
    }
  end
  
  context do
    before { patch '/api/profile/chats/1/messages/1', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { patch '/api/profile/chats/1/messages/1', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Conversation was not found' do
    before { patch '/api/profile/chats/0/messages/1', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'invalid params' do
    before { patch '/api/profile/chats/1/messages/1', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
