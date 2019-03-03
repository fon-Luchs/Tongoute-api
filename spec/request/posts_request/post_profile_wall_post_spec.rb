require 'rails_helper'

RSpec.describe 'PostWallProfilePost', type: :request do
  let(:user) { create(:user, :with_auth_token, :with_wall)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { post: resource_params } }

  let(:resource_params) { { postable_id: user.id, postable_type: user.class.name, wall_id: user.wall.id, body: 'first post' } }

  let(:author) do
    {
      'id' => user.id,
      'name' => "#{user.first_name} #{user.last_name}"
    }
  end

  let(:resource_response) do
    {
      'author' => author,
      'body' => wall_post.body,
      'id' => wall_post.id,
      'likes' => 332
    }
  end

  before { build(:post, postable: user, wall: user.wall) }

  let(:wall_post) { Post.last }

  context do
    before { post '/api/profile/wall/posts', params: params.to_json, headers: headers }

    it('returns wall') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/wall/posts', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/profile/wall/posts', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
