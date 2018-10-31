require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  before { sign_in user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  before { request.headers.merge!(headers) }

  describe '#show.json' do
    before { get :show, params: {id: user.id.to_s}, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    before { get :index, format: :json }

    it { should render_template :index }
  end

  describe 'routes test' do
    it { should route(:get, '/api/users/1').to(action: :show, controller: 'api/users', id: 1) }

    it { should route(:get, '/api/users').to(action: :index, controller: 'api/users') }
  end
end
