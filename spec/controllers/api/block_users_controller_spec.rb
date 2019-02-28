require 'rails_helper'

RSpec.describe Api::BlockUsersController, type: :controller do
  describe 'routes test' do
    it { should route(:get, '/api/profile/blacklist').to(action: :index, controller: 'api/block_users') }

    it { should route(:get, '/api/profile/blacklist/1').to(action: :show, controller: 'api/block_users', id: 1) }

    it { should route(:post, '/api/users/1/block').to(action: :create, controller: 'api/block_users', user_id: 1) }

    it { should route(:delete, '/api/profile/blacklist/1/unblock').to(action: :destroy, controller: 'api/block_users', id: 1) }

    it { should route(:patch, '/api/profile/friends/1/block').to(action: :update, controller: 'api/block_users', friend_id: 1) }
  end

  let(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:block_user) { create(:user) }

  let(:ban) { create(:relation, relating_id: user.id, related_id: block_user.id) }

  before { sign_in user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) { { block_user: { related_id: block_user.id, state: 2 } } }

  let(:permitted_params) { permit_params! params, :block_user }

  describe '#create.json' do
    before do
      expect(user).to receive_message_chain(:relations, :new)
        .with(no_args).with(permitted_params)
        .and_return(ban)
    end

    context 'success' do
      before { expect(ban).to receive(:save).and_return(true) }

      before { merge_header }

      before { post :create, params: { user_id: block_user.id }, format: :json }

      it { should render_template :create }
    end

    context 'fails' do
      before { expect(ban).to receive(:save).and_return(false) }

      before { merge_header }

      before { post :create, params: { user_id: block_user.id }, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#destroy.json' do
    let(:params) { { user_id: block_user.id, id: ban.id } }

    before { expect(subject).to receive(:destroy) }

    before { merge_header }

    before { delete :destroy, params: params, format: :json }

    it { expect(response).to have_http_status(204) }
  end

  describe '#show.json' do
    before { merge_header }

    before { get :show, params: { id: ban.id }, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    before { merge_header }

    before { get :index, params: {}, format: :json }

    it { should render_template :index }
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
