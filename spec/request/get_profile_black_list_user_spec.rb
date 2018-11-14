require 'rails_helper'

RSpec.describe 'ProfileBlackListUser', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:b_user) { create(:user) }

  let!(:ban)    { create(:block_user, user: user, blocked_id: b_user, id: 2) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    {
      "id" => b_user.id,
      "name" => "#{b_user.first_name} #{b_user.last_name}",
      "status" => 'Blocked'
    }
  end

  context do
    before { get '/api/profile/blacklist/2', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/blacklist/2', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end