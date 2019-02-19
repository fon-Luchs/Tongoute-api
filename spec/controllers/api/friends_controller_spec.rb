require 'rails_helper'

RSpec.describe Api::FriendsController, type: :controller do
  describe 'test routes' do
    it { should route(:get, '/api/profile/friends').to(action: :index, controller: 'api/friends') }

    it { should route(:get, '/api/profile/friends/1').to(action: :show, controller: 'api/friends', id: 1) }

    it { should route(:get, '/api/users/1/friends').to(action: :index, controller: 'api/friends', user_id: 1) }

    it { should route(:get, '/api/users/1/friends/1').to(action: :show, controller: 'api/friends', user_id: 1, id: 1) }

    it { should route(:post, '/api/profile/subscribers/1/accept').to(action: :create, controller: 'api/friends', subscriber_id: 1) }

    it { should route(:delete, '/api/profile/friends/1/remove').to(action: :destroy, controller: 'api/friends', friend_id: 1) }
  end

  let(:user)        { create(:user, :with_auth_token, id: 2) }

  let(:friend_user) { create(:user, id: 1) }

  let(:subscribe)        { create(:relationship, subscribed_id: user.id, subscriber_id: friend_user.id) }

  let(:friend_subscribe) { create(:relationship, subscribed_id: friend_user.id, subscriber_id: user.id) }

  let(:value)            { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#show.json' do
    let(:params) { { id: friend_user.id } }

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
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
