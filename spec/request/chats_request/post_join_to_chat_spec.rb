require 'rails_helper'

RSpec.describe 'PostJoinToChat', type: :request do

  let(:user) { create(:user, :with_auth_token)}

  let(:creator) { create(:user) }

  let!(:chat) { create(:chat, creator_id: creator.id, id: 1) }

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

  before { build(:user_chat, chat_id: chat.id, user_id: user.id, role: 0) }

  let(:join) { UserChat.last }

  let(:chat_response) do
    {
      "chat_message" => "Joined to #{chat.name}"
    }
  end

  context do
    before { post '/api/profile/chats/1/join', params: params.to_json, headers: headers }

    it('returns created chat') { expect(JSON.parse(response.body)).to eq chat_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }

    it { expect { JSON.parse response.body }.not_to raise_error }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/chats/1/join', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'chat was not found' do
    before { post '/api/profile/chats/0/join', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
