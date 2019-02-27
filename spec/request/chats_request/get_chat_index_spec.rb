require 'rails_helper'

RSpec.describe 'GetChatIndex', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let!(:chat)   { create(:chat, creator_id: user.id, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author) do
    {
      'id' => user.id,
      'name' => "#{user.first_name} #{user.last_name}"
    }
  end

  let(:last_message) do
    {
      'author' => author,
      'id' => message.id,
      'text' => message.text
    }
  end

  let(:resource_response) do
    Chat.all.map do |c|
      {
        'id' => c.id,
        'name' => c.name,
        'author' => author,
        'last_message' => last_message
      }
    end
  end

  before { create(:user_chat, chat_id: chat.id, user_id: user.id, role: 2) }

  before { create(:message, user_id: user.id,
                            messageable_id: chat.id,
                            messageable_type: chat.class.name ) }

  let(:message) { Message.last }

  context do
    before { get '/api/profile/chats', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/chats', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
