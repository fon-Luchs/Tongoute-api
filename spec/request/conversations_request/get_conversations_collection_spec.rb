require 'rails_helper'

RSpec.describe 'GetConversationCOllection', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let(:recipient) { create(:user) }

  let!(:conversation) { create(:conversation, senderable: user, recipientable: recipient) }

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

  let(:interlocutor) do
    {
      'id' => recipient.id,
      'name' => "#{recipient.first_name} #{recipient.last_name}",
      'type' => recipient.class.name 
    }
  end

  let(:resource_response) do
    Conversation.all.map do |c|
      {
        'id' => c.id,
        'interlocutor' => interlocutor,
        'last_message' => last_message
      }
    end
  end

  before { create(:message, user_id: user.id,
    messageable_id: conversation.id,
    messageable_type: conversation.class.name ) }

let(:message) { Message.last }

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
