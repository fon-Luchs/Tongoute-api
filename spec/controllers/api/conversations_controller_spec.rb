require 'rails_helper'

RSpec.describe Api::ConversationsController, type: :controller do
  describe 'routes test' do
    it { should route(:get, 'api/profile/conversations/1').to(action: :show, controller: 'api/conversations', id: 1) }

    it { should route(:get, 'api/profile/conversations').to(action: :index, controller: 'api/conversations') }

    it { should route(:post, 'api/users/1/conversations').to(action: :create, controller: 'api/conversations', user_id: 1) }

    it { should route(:get, 'api/users/1/conversations/1').to(action: :show, controller: 'api/conversations', user_id: 1, id: 1) }
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

  let(:params) do
    {
      conversation:
      {
        recipient_id: recipient.id.to_s
      }
    }
  end

  before { sign_in user }

  let(:permited_params) { permit_params! params, :conversation }

  describe '#create.json' do
    before { build_resource }

    context 'success' do
      before { expect(conversation).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: { user_id: recipient.id }, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(conversation).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: { user_id: recipient.id }, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    let(:params) { { id: conversation.id } }

    before { merge_headers headers }

    before { get :show, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    before { merge_headers headers }

    before { get :index, format: :json }

    it { should render_template :index }
  end

  def build_resource
    expect(user).to receive_message_chain(:active_conversations, :new)
      .with(no_args).with(permited_params)
      .and_return(conversation)
  end
end
