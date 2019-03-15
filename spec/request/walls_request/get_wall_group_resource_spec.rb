require 'rails_helper'

RSpec.describe 'GetWallGroupResource', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 1)}

  let(:creator) { create(:user) }

  let(:group) { create(:group, :with_wall, creator_id: creator.id, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author) do
    {
      "id" => group.id,
      "name" => group.name
    }
  end

  let(:posts) do
    group.wall.posts.map do |p|
      {
        "author" => author,
        "id" => p.id,
        "body" => p.body,
        "likes" => 332
      }
    end
  end

  let(:post_response) do
    {
      "id" => group.wall.id,
      "owner" => author,
      "posts" => posts
    }
  end

  before { create(:post, postable: group, wall: group.wall) }

  context do
    before { get '/api/groups/1/wall', params: {}, headers: headers }

    it('returns wall') { expect(JSON.parse(response.body)).to eq post_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/groups/1/wall', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
