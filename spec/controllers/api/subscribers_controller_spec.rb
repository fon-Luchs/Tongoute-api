require 'rails_helper'

RSpec.describe Api::SubscribersController, type: :controller do
  describe 'routes test' do
    it { should route(:get, '/api/profile/subscribers').to(action: :index, controller: 'api/subscribers') }

    it { should route(:get, '/api/users/1/subscribers').to(action: :index, controller: 'api/subscribers', user_id: 1) }

    it { should route(:get, '/api/profile/subscribers/1').to(action: :show, controller: 'api/subscribers', id: 1) }
  end
  
  let(:user) { create(:user, :with_auth_token, :with_information) }

  let(:sub_user) { create(:user) }

  let(:value) { user.auth_token.value }
  
  let(:relationship) { create(:relation, relating_id: sub_user.id, related_id: user.id, id: 1) }

  before { sign_in user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#show.json' do
    before { merge_header }

    before { get :show, params: { id: relationship.id }, format: :json }

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
