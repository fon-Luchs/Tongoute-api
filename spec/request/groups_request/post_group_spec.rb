require 'rails_helper'

RSpec.describe 'PatchGroup', type: :request do
  let(:user)    { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { group: resource_params } }

  let(:resource_params) { attributes_for(:group) }

  let(:author) do
    {
      'id' => user.id,
      'name' => "#{user.first_name} #{user.last_name}"
    }
  end

  let(:wall) do
    {
      'id' => group.wall.id,
      'owner' => { 'id' => group.id, 'name' => group.name },
      'posts' => []
    }
  end

  let(:resource_response) do
    {
      'id' => group.id,
      'name' => group.name,
      'author' => author,
      'wall' => wall,
      'users' => [
        {
        'id' => user.id,
        'name' => "#{user.first_name} #{user.last_name}",
        'location' => ", "
        }
      ]
    }
  end

  before {  build(:group, creator_id: user.id) }

  let(:group) { Group.last }

  context do
    before { post '/api/profile/groups', params: params.to_json, headers: headers }

    before { create(:wall, wallable: group) }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/groups', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/profile/groups', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
