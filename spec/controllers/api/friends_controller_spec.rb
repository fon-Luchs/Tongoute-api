require 'rails_helper'

RSpec.describe Api::FriendsController, type: :controller do
  describe 'test routes' do
    it { should route(:get, '/api/profile/friends').to(action: :index, controller: 'api/friends') }

    it { should route(:get, '/api/profile/friends/1').to(action: :show, controller: 'api/friends', id: 1) }

    it { should route(:get, '/api/users/1/friends').to(action: :index, controller: 'api/friends', user_id: 1) }

    it { should route(:post, '/api/profile/subscribers/1/accept').to(action: :create, controller: 'api/friends', subscriber_id: 1) }

    it { should route(:delete, '/api/profile/friends/1/remove').to(action: :destroy, controller: 'api/friends', friend_id: 1) }
  end

  let(:user)        { create(:user, :with_auth_token, id: 1) }

  let(:friend_user) { create(:user, id: 2) }

  let(:subscribe)        { create(:relation, related_id: user.id, relating_id: friend_user.id, id: 11) }

  let(:friend_subscribe) { create(:relation, related_id: friend_user.id, relating_id: user.id, id: 22) }

  let(:value)            { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) { { friend: { related_id: subscribe.initiator.id } } }

  let(:permitted_params) { permit_params! params, :friend }

  before { sign_in user }

  describe '#create.json' do
    before do
      expect(RelationsTypeGetter).to receive(:new).with(user) do
        double.tap do |r|
          expect(r).to receive_message_chain(:subscribers, :find)
            .with(no_args).with(friend_user.id.to_s).and_return(subscribe)
        end
      end
    end

    before do
      expect(user).to receive_message_chain(:relations, :new)
        .with(no_args).with(permitted_params)
        .and_return(friend_subscribe)
    end

    context 'success' do
      before { expect(friend_subscribe).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: { subscriber_id: friend_user.id }, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(friend_subscribe).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: { subscriber_id: friend_user.id }, format: :json }

      it { should render_template :errors }
    end
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
