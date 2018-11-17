require 'rails_helper'

RSpec.describe Api::SubscribingsController, type: :controller do
  describe 'routes test' do
    it { should route(:get, '/api/profile/subscribings').to(action: :index, controller: 'api/subscribings') }

    it { should route(:get, '/api/profile/subscribings/1').to(action: :show, controller: 'api/subscribings', id: 1) }

    it { should route(:post, '/api/users/1/request').to(action: :create, controller: 'api/subscribings', user_id: 1) }
  end
  
  let(:user) { create(:user, :with_auth_token, :with_information) }

  let(:sub_user) { create(:user) }

  let(:value) { user.auth_token.value }
  
  let(:subscribe) { create(:relationship, subscriber_id: user.id, subscribed_id: sub_user.id) }

  before { sign_in user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#create.json' do
  
  before { expect(User).to receive(:find).with(sub_user.id.to_s).and_return(sub_user) }

  before do
    expect(user).to receive_message_chain(:active_relationship, :new)
      .with(no_args).with(subscribed_id: sub_user.id)
      .and_return(subscribe)
  end

    context 'success' do
      before { expect(subscribe).to receive(:save).and_return(true) }

      before { merge_header }

      before { post :create, params: { user_id: sub_user.id }, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(subscribe).to receive(:save).and_return(false) }

      before { merge_header }

      before { post :create, params: { user_id: sub_user.id }, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    before { merge_header }

    before { get :show, params: { id: subscribe.id }, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    before { merge_header }

    before { get :index, format: :json }

    it { should render_template :index }
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
