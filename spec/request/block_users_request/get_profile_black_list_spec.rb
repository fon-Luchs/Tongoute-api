require 'rails_helper'

RSpec.describe 'ProfileBlackList', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let(:b_user)  { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let(:ban)     { create(:relation, related_id: b_user.id, relating_id: user.id) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    Relation.banned.map do |ban|
      b_user = User.find(ban.blocked_id)
      {
        "id" => b_user.id,
        "name" => "#{b_user.first_name} #{b_user.last_name}",
        "status" => 'Blocked'
      }
    end
  end

  context do
    before { get '/api/profile/blacklist', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/blacklist', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end