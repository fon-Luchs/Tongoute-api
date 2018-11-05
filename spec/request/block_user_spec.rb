require 'rails_helper'

RSpec.describe 'BlockUser', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_params) { attributes_for(:block) }

  let(:params) { { block: resource_params } }

  let(:block) { Block.last }

  let(:resource_response) do
    {
      "id" => user.id,
      "name" => "#{user.name} #{user.last_name}",
      "status" => 'Blocked'
    }
  end

  before { create(:block, resource_params.merge(user: user)) }

  context do
    before { post '/api/user/1/block', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/user/1/block', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/user/1/block', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end