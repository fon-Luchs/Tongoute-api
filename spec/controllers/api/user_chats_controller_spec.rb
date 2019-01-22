require 'rails_helper'

RSpec.describe Api::UserChatsController, type: :controller do
  describe 'routes test' do
    it { should route(:post, '/api/profile/chats/1/join').to(action: :create, controller: 'api/user_chats', chat_id: 1) }
    
    it { should route(:delete, '/api/profile/chats/1/leave').to(action: :destroy, controller: 'api/user_chats', chat_id: 1) }

    it { should route(:patch, '/api/profile/chats/1/update').to(action: :update, controller: 'api/user_chats', chat_id: 1) }
  end

  let(:user)  { create(:user, :with_auth_token) }

  let(:chat)  { create(:chat, creator_id: user.id, id: 2 ) }

  let(:user_chat) { create(:user_chat, chat: chat, user: user, role: 0) }

  let(:value) { user.auth_token.value }

  let(:request_headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) { { user_chat: { chat_id: chat.id.to_s, user_id: user.id, role: 0 } } }

  let(:permitted_params) { permit_params! params, :user_chat }

  before { sign_in user }

  describe '#create#json' do
    let(:params)  { { chat_id: chat.id, user_chat: { chat_id: chat.id.to_s, user_id: user.id, role: 0 } } }

    before { expect(UserChat).to receive(:find_or_initialize_by).with(permitted_params).and_return(user_chat) }

    context 'success' do
      before{ expect(user_chat).to receive(:save).and_return(true) }

      before{ merge_headers request_headers }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before{ expect(user_chat).to receive(:save).and_return(false) }

      before{ merge_headers request_headers }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'delete#json' do
    let(:params) { {user_id: user.id, chat_id: chat.id.to_s} }

    before { expect(UserChat).to receive(:find_by!).with(params).and_return(user_chat) }

    before { merge_headers request_headers }

    before { delete :destroy, params: { chat_id: chat.id }, format: :json }

    it { expect(response).to have_http_status(204) }
  end

  describe 'update#json' do
  end
end
