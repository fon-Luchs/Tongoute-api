require 'rails_helper'

RSpec.describe 'GetGroupIndex', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let!(:group)   { create(:group, :with_wall, creator_id: user.id, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

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
    user.groups.map do |g|
      {
        'id' => g.id,
        'author' => author,
        'name' => g.name
      }
    end
  end

  before { group.users << user }

  context do
    before { get '/api/profile/groups', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/groups', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end