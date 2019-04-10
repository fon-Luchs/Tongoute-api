require 'rails_helper'

RSpec.describe Api::MessagesController, type: :controller do
  describe 'routes' do
    it { should route(:post, 'api/profile/conversations/1/messages').to(action: :create, controller: 'api/messages', conversation_id: 1) }

    it { should route(:patch, 'api/profile/conversations/1/messages/1').to(action: :update, controller: 'api/messages', conversation_id: 1, id: 1) }

    it { should route(:post, 'api/profile/chats/1/messages').to(action: :create, controller: 'api/messages', chat_id: 1) }

    it { should route(:patch, 'api/profile/chats/1/messages/1').to(action: :update, controller: 'api/messages', chat_id: 1, id: 1) }

    it { should route(:post, 'api/groups/1/messages').to(action: :create, controller: 'api/messages', group_id: 1) }

    it { should route(:patch, 'api/groups/1/messages/1').to(action: :update, controller: 'api/messages', group_id: 1, id: 1) }
  end

  let(:user)  { create(:user, :with_auth_token) }

  let(:chat)  { create(:chat, creator_id: user.id, id: 2 ) }

  let(:message) do
    create(
      :message, user_id: user.id,
      messageable_id: chat.id,
      messageable_type: chat.class.name
    )
  end

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) { { message: { text: message.text, user_id: message.user.id } } }

  let(:permitted_params) { permit_params! params, :message }

  before { sign_in user }

  describe 'create#json' do
    let(:params) { { chat_id: chat.id, message: { text: message.text, user_id: message.user.id } } }

    before { expect(Chat).to receive(:find).with(chat.id.to_s).and_return(chat) }

    before do
      expect(chat).to receive_message_chain(:messages, :new)
        .with(no_args).with(permitted_params).and_return(message)
    end

    context 'success' do
      before { expect(message).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(message).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'update#json' do
    let(:params) { { chat_id: chat.id, id: message.id, message: { text: message.text } } }

    before do 
      expect(Message).to receive(:find_by!)
                        .with(user_id: user.id, messageable_id: chat.id, messageable_type: chat.class.name)
                        .and_return(message)
    end

    context 'success' do
      before { expect(message).to receive(:update).and_return(true) }

      before { merge_headers headers }

      before { patch :update, params: params, format: :json  }

      it { should render_template :update }
    end

    context ' fail' do
      before { expect(message).to receive(:update).and_return(false) }

      before { merge_headers headers }

      before { patch :update, params: params, format: :json  }

      it { should render_template :errors }
    end
  end
end
