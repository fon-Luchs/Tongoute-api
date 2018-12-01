require 'rails_helper'

RSpec.describe Api::ConversationsController, type: :controller do
  describe 'routes test' do
    it { should route(:get, 'api/profile/conversations/1').to(action: :show, controller: 'api/conversations', id: 1) }
  end

  let(:user) { create(:user, :with_auth_token) }

  let(:recipient) { create(:user) }

  let(:conversation) { create(:conversation, sender: user, recipient: recipient) }

  let(:value)            { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#show.json' do
    let(:params) { { id: conversation.id } }

    before { merge_headers headers }

    before { get :show, params: params, format: :json }

    it { should render_template :show }
  end
end
