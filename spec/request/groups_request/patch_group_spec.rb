require 'rails_helper'

RSpec.describe 'PatchGroup', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let!(:group)   { create(:group, :with_wall, creator_id: user.id, id: 1) }

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
      'owner' => { 'id' => group.id, 'name' => Group.last.name },
      'posts' => []
    }
  end

  let(:resource_response) do
    {
      'id' => group.id,
      'name' => Group.last.name,
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

  before { group.users << user }

  context do
    before { patch '/api/groups/1', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { patch '/api/groups/1', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'group was not found' do
    before { patch '/api/groups/0', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'invalid params' do
    before { patch '/api/groups/1', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
