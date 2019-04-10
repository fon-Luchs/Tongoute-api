require 'rails_helper'

RSpec.describe Api::FriendsController, type: :controller do
  describe 'test routes' do
    it { should route(:get, '/api/profile/friends').to(action: :index, controller: 'api/friends') }

    it { should route(:get, '/api/profile/friends/1').to(action: :show, controller: 'api/friends', id: 1) }

    it { should route(:get, '/api/users/1/friends').to(action: :index, controller: 'api/friends', user_id: 1) }

    it { should route(:post, '/api/profile/subscribers/1/accept').to(action: :create, controller: 'api/friends', subscriber_id: 1) }

    it { should route(:delete, '/api/profile/friends/1/remove').to(action: :destroy, controller: 'api/friends', friend_id: 1) }
  end

  let(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:subscriber) { create(:user) }

  before { sign_in user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) { { friend: { related_id: subscriber.id} } }

  let(:permitted_params) { permit_params! params, :friend }

  describe '#create.json' do
    before { create(:relation, related_id: user.id, relating_id: subscriber.id) }

    let(:friend_response) { build(:relation, related_id: subscriber.id, relating_id: user.id) }

    let(:subscribe) { Relation.last }

    before do
      expect(user).to receive_message_chain(:relations, :new)
        .with(no_args).with(permitted_params)
        .and_return(friend_response)
    end

    context 'success' do
      before { expect(friend_response).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: { subscriber_id: subscribe.id }, format: :json }

      it { should render_template :create }
    end

    context 'fails' do
      before { expect(friend_response).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: { subscriber_id: subscribe.id }, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    let(:friend_response) { create(:relation, related_id: subscriber.id, relating_id: user.id) }

    let(:params) { { id: friend_response.id } }

    before { merge_headers headers }

    before { get :show, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    before { merge_headers headers }

    before { get :index, format: :json }

    it { should render_template :index }
  end

  describe '#destroy.json' do
    let(:friend_response) { create(:relation, related_id: subscriber.id, relating_id: user.id) }

    let(:params) { { friend_id: friend_response.id } }

    before { expect(subject).to receive(:destroy) }

    before { merge_headers headers }

    before { delete :destroy, params: params, format: :json }

    it { expect(response).to have_http_status(204) }
  end

end
