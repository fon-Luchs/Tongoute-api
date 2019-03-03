require 'rails_helper'

RSpec.describe 'PatchUserWallPost', type: :request do
  let(:wall_owner) { create(:user, :with_wall, id: 1)}

  let(:user) { create(:user, :with_auth_token) }

  let!(:wall_post) { create(:post, postable: user, wall: wall_owner.wall, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { post: resource_params } }

  let(:resource_params) { { postable_id: user.id, postable_type: user.class.name, wall_id: wall_owner.wall.id, body: 'first post' } }

  let(:author) do
    {
      'id' => user.id,
      'name' => "#{user.first_name} #{user.last_name}"
    }
  end

  let(:resource_response) do
    {
      'author' => author,
      'body' => updated_body,
      'id' => wall_post.id,
      'likes' => 332
    }
  end

  let(:updated_body) { Post.last.body }

  context do
    before { patch '/api/users/1/wall/posts/1', params: params.to_json, headers: headers }

    it('returns wall') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { patch '/api/users/1/wall/posts/1', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { patch '/api/users/1/wall/posts/1', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end

  context 'post was not found' do
    before { patch '/api/users/1/wall/posts/0', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'user was not found' do
    before { patch '/api/users/0/wall/posts/1', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
