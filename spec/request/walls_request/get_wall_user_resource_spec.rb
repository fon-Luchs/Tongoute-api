require 'rails_helper'

RSpec.describe 'GetWallProfileResource', type: :request do
  let(:wall_owner) { create(:user, :with_wall, id: 1)}

  let(:user)  { create(:user, :with_auth_token) }

  # let(:wall) { create(:wall, wallable: wall_owner) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:owner) do
    {
      'id' => wall_owner.id,
      'name' => "#{wall_owner.first_name} #{wall_owner.last_name}"
    }
  end

  let(:author) do
    {
      'id' => user.id,
      'name' => "#{user.first_name} #{user.last_name}"
    }
  end

  let(:posts) do
    wall_owner.wall.posts.map do |p|
      {
        'author' => author,
        'body' => p.body,
        'id' => p.id,
        'likes' => 332
      }
    end
  end

  let(:resource_response) do
    {
      'id' => wall_owner.wall.id,
      'owner' => owner,
      'posts' => posts
    }
  end

  before { create(:post, postable: user, wall: wall_owner.wall) }

  context do
    before { get '/api/users/1/wall', params: {}, headers: headers }

    it('returns wall') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/users/1/wall', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'user was not found' do
    before { get '/api/users/0/wall', params: {} , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
