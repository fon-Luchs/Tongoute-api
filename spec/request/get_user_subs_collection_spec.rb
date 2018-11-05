require 'rails_helper'

RSpec.describe 'GetUserSubsCollection', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let!(:sub) { create(:sub, user: user, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:note_response) do
    Sub.all.map do |s|
      {
        "id" => s.user.id,
        "name" => "#{s.user.firs_name} #{s.user.last_name}",
        "status" => 'subscriber'
      }
    end
  end

  before { create(:friend, resource_params.merge(user: user)) }

  context do
    before { post '/api/users/1/subscribers/', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/1/subscribers/', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
