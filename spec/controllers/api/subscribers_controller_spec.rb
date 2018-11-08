require 'rails_helper'

RSpec.describe Api::SubscribersController, type: :controller do
  describe 'routes test' do
    it { should route(:get, '/api/profile/subscribers').to(action: :index, controller: 'api/subscribers') }

    it { should route(:get, '/api/profile/subscribers/1').to(action: :show, controller: 'api/subscribers', id: 1) }

    it { should route(:get, '/api/users/1/subscribers').to(action: :index, controller: 'api/subscribers', user_id: 1) }

    it { should route(:post, '/api/users/1/request').to(action: :create, controller: 'api/subscribers', user_id: 1) }
  end

  let(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:sub_user) { create(:user) }

  let(:subscriber) { create(:subscriber, user: user, subscriber_id: sub_user.id) }

  before { sign_in user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#create.json' do
    before { expect(User).to receive(:find).with(user.id.to_s).and_return(user) }

    before { expect(user).to receive_message_chain(:subscribers, :new).and_return(subscriber) }

    context 'success' do
      before { expect(subscriber).to receive(:save).and_return(true) }

      before { merge_header }

      before { post :create, params: { user_id: user.id }, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(subscriber).to receive(:save).and_return(false) }

      before { merge_header }

      before { post :create, params: { user_id: user.id }, format: :json }

      it { should render_template :errors }
    end

  end

  describe '#show.json' do
    before { merge_header }

    before { get :show, params: { id: subscriber.id }, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    context 'User' do
      before { merge_header }

      before { get :index, params: { user_id: user.id }, format: :json }
  
      it { should render_template :index }
    end

    context 'Profile' do
      before { merge_header }

      before { get :index, format: :json }
  
      it { should render_template :index }
    end
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
