require 'rails_helper'

RSpec.describe 'BlockUserFriend', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:b_user) { create(:user, id: 1) }
  
  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { block_user: resource_params } }

  let(:resource_params) { attributes_for(:black_list) }

  before { create(:black_list, resource_params.merge(blocker_id: b_user.id, blocked_id: user.id)) }

  let(:block) { ActiveBlock.last }

  let(:block_response) do
    {
      "lol" => "lol"
    }
  end

  before { post '/api/users/1/block', params: params.to_json, headers: headers }

  context do
    it('returns created block') { expect(JSON.parse(response.body)).to eq block_response }
  end
end
