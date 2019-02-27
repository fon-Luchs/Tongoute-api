require 'rails_helper'

RSpec.describe 'PatchChatName', type: :request do

  let(:user) { create(:user, :with_auth_token)}

  let(:chat) { create(:chat, creator_id: user.id, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) do
     {
       'Authorization' => "Token token=#{value}",
       'Content-type' => 'application/json',
       'Accept' => 'application/json'
     }
  end

  let(:params) { { chat: resource_params } }

  let(:resource_params) { attributes_for(:chat) }

  let(:author) do
    {
      'id' => user.id,
      'name' => "#{user.first_name} #{user.last_name}"
    }
  end

  let(:resource_response) do
    {
      'id' => chat.id,
      'name' => Chat.last.name,
      'author' => author,
      'messages' => [],
      'users' => [
        {
        'id' => user.id,
        'name' => "#{user.first_name} #{user.last_name}",
        'location' => ", "
        }
      ]
    }
  end

  before { create(:user_chat, chat_id: chat.id, user_id: user.id, role: 2) }

  context do
    before { patch '/api/profile/chats/1', params: params.to_json, headers: headers }

    it('returns created chat') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }

    it { expect { JSON.parse response.body }.not_to raise_error }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { patch '/api/profile/chats/1', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'chat was not found' do
    before { patch '/api/profile/chats/0', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'invalid params' do
    before { patch '/api/profile/chats/1', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
