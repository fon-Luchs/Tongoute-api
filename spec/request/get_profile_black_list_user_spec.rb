require 'rails_helper'

RSpec.describe 'ProfileBlackListUser', type: :request do
  let(:user) { create(:user, :with_auth_token) }
  
  let(:b_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski', id: 1) }

  let(:ban)    { create(:block_user, user: user, blocked_id: b_user) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    {
      "id" => b_user.id,
      "name" => "#{b_user.first_name} #{b_user.last_name}",
      "status" => 'Banned'
    }
  end

  before { create(:black_list, blocker: user, blocked: b_user) }

  context do
    before { get '/api/profile/blacklist/1', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/blacklist/1', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end