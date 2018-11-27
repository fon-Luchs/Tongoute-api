require 'rails_helper'

RSpec.describe 'BlockUserFriend', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:b_user) { create(:user, id: 1) }
  
  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_params) { attributes_for(:black_list) }

  let(:params) { { block_user: resource_params } }

  let(:block) { ActiveBlock.last }

  let(:resource_response) do
    {
      "id" => b_user.id,
      "name" => "#{b_user.first_name} #{b_user.last_name}",
      "status" => 'Blocked'
    }
  end

  before { create(:black_list, resource_params.merge(blocker_id: b_user.id, blocked_id: user.id)) }

  context do
    before { post '/api/users/1/block', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/1/block', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/users/10/block', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end