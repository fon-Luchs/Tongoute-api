require 'rails_helper'

RSpec.describe 'GetWallProfileResource', type: :request do
  let(:user) { create(:user, :with_auth_token, :with_wall)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:owner) do
    {
      'id' => user.id,
      'name' => "#{user.first_name} #{user.last_name}"
    }
  end

  let(:posts) do
    user.wall.posts.map do |p|
      {
        'author' => owner,
        'body' => p.body,
        'id' => p.id,
        'likes' => 332
      }
    end
  end

  let(:resource_response) do
    {
      'id' => user.wall.id,
      'owner' => owner,
      'posts' => posts
    }
  end

  before { create(:post, postable: user, wall: user.wall) }

  context do
    before { get '/api/profile/wall', params: {}, headers: headers }

    it('returns wall') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/wall', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
