require 'rails_helper'

RSpec.describe Api::FriendsController, type: :controller do
  describe 'test routes' do
    it { should route(:delete, '/api/profile/friends/1/remove').to(action: :destroy, controller: 'api/friends', friend_id: 1) }

    it { should route(:get, '/api/profile/friends').to(action: :index, controller: 'api/friends') }

    it { should route(:get, '/api/profile/friends/1').to(action: :show, controller: 'api/friends', id: 1) }

    it { should route(:post, '/api/profile/subscribers/1/accept').to(action: :create, controller: 'api/friends', subscriber_id: 1) }

    it { should route(:get, '/api/users/1/friends').to(action: :index, controller: 'api/friends', user_id: 1) }

    it { should route(:get, '/api/users/1/friends/1').to(action: :show, controller: 'api/friends', user_id: 1, id: 1) }

    it { should route(:post, '/api/users/1/accept').to(action: :create, controller: 'api/friends', user_id: 1) }
  end

  let(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:sub_user)   { create(:user) }

  let(:subscriber) { create(:subscriber, user: user, subscriber_id: sub_user.id) }

  let(:friendship) { create(:friend, user: user, friend_id: subscriber.subscriber_id) }

  describe '#create.json' do

    before { expect(subject).to receive(:build_resource) }

    before { expect(subject).to receive(:resource).and_return(friendship) }

    context 'success' do
      before { expect(friendship).to receive(:save).and_return(true) }

      before { merge_header }

      before { post :create, params: { user_id: sub_user.id.to_s }, format: :json }

      it { should render_template :create }
    end

    context 'fails' do
      before { expect(friendship).to receive(:save).and_return(false) }

      before { merge_header }

      before { post :create, params: { user_id: sub_user.id.to_s }, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    let(:params) { { user_id: sub_user.id.to_s, id: friendship.id.to_s } }

    before { merge_header }

    before { get :show, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    before { merge_header }

    before { get :index, format: :json }

    it { should render_template :index }
  end

  describe '#destroy.json' do
    let(:params) { { user_id: sub_user.id.to_s, id: friendship.id.to_s } }

    before { merge_header }

    before { delete :destroy, params: params, format: :json }

    it { expect(response).to have_http_status(204) }
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
