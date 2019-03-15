require 'rails_helper'

RSpec.describe 'PostJoinToChat', type: :request do

  let(:user) { create(:user, :with_auth_token)}

  let(:creator) { create(:user) }

  let!(:group) { create(:group, creator_id: creator.id, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) do
     {
       'Authorization' => "Token token=#{value}",
       'Content-type' => 'application/json',
       'Accept' => 'application/json'
     }
  end

  let(:params) { { group: resource_params } }

  let(:resource_params) { attributes_for(:group) }

  before { build(:user_group, group_id: group.id, user_id: user.id) }

  let(:join) { UserGroup.last }

  let(:group_response) do
    {
      "welcome" => "joined to #{group.name}"
    }
  end

  context do
    before { post '/api/groups/1/join', params: params.to_json, headers: headers }

    it('returns created chat') { expect(JSON.parse(response.body)).to eq group_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }

    it { expect { JSON.parse response.body }.not_to raise_error }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/groups/1/join', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
