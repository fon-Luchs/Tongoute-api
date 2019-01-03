require 'rails_helper'

RSpec.describe Api::ChatsController, type: :controller do
  describe 'routes test' do
    it { should route(:get, 'api/profile/chats/1').to(action: :show, controller: 'api/chats', id: 1) }

    it { should route(:get, 'api/profile/chats').to(action: :index, controller: 'api/chats') }

    it { should route(:post, 'api/profile/chats').to(action: :create, controller: 'api/chats') }

    it { should route(:put, 'api/profile/chats/1').to(action: :update, controller: 'api/chats', id: 1) }

    it { should route(:patch, 'api/profile/chats/1').to(action: :update, controller: 'api/chats', id: 1) }

    it { should route(:delete, 'api/profile/chats/1').to(action: :destroy, controller: 'api/chats', id: 1) }
  end

  let(:user)  { create(:user, :with_auth_token) }

  let(:chat)  { create(:chat, creator_id: user.id, id: 2 ) }

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) do
    {
      chat:
      {
        name: chat.name,
        creator_id: chat.creator_id
      }
    }
  end

  let(:permitted_params) { permit_params! params, :chat }

  before { sign_in user }

  describe 'create#json' do
    before do
      expect(user).to receive_message_chain(:chats, :new)
        .with(no_args).with(permitted_params)
        .and_return(chat)
    end

    context 'success' do
      before { expect(chat).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'false' do
      before { expect(chat).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'update#json' do
    let(:params) { { chat: { name: chat.name }, id: chat.id } }

    before do
      expect(user).to receive_message_chain(:chats, :find)
        .with(no_args).with(chat.id.to_s)
        .and_return(chat)
    end

    context 'success' do
      before { expect(chat).to receive(:update).and_return(true) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'false' do
      before { expect(chat).to receive(:update).and_return(false) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'delete#json' do
    before do
      expect(user).to receive_message_chain(:chats, :find)
        .with(no_args).with(chat.id.to_s)
        .and_return(chat)
    end

    before { merge_headers headers }

    before { delete :destroy, params: { id: chat.id }, format: :json }

    it { expect(response).to have_http_status(204) }
  end

  describe 'show#json' do
    before { merge_headers headers }

    before { get :show, params: { id: chat.id.to_s }, format: :json }

    it { should render_template :show }
  end

  describe 'index#json' do
    before { merge_headers headers }

    before { get :index, format: :json }

    it { should render_template :index }
  end
end
