require 'rails_helper'

RSpec.describe Api::WallsController, type: :controller do
  describe 'routes test' do
    it { should route(:get, '/api/profile/wall').to(action: :show, controller: 'api/walls') }

    it { should route(:get, '/api/users/1/wall').to(action: :show, controller: 'api/walls', user_id: 1) }
  end

  let(:user)  { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:wall)  { create(:wall, wallable: user) }

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

    before { get :show, params: { user_id: user.id }, format: :json }

    it { should render_template :show }
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
