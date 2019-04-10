require 'rails_helper'

RSpec.describe 'GetGroupConversation', type: :request do
  let(:user)    { create(:user, :with_auth_token) }

  let(:group)   { create(:group, creator_id: user.id, id: 1) }

  let!(:conversation) { create(:conversation, senderable: group, recipientable: recipient, id: 1) }

  let(:recipient) { create(:user, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author) do
    {
      'id' => user.id,
      'name' => "#{user.first_name} #{user.last_name}"
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
    {
      'id' => conversation.id,
      'interlocutor' => interlocutor,
      'messages' => []
    }
  end

  context do
    before { get '/api/groups/1/conversations/1?as_group=true', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/groups/1/conversations/1?as_group=true', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Group was not found' do
    before { get '/api/groups/0/conversations/1?as_group=true', params: {}, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'Conversation was not found' do
    before { get '/api/groups/1/conversations/0?as_group=true', params: {}, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
