require 'rails_helper'

RSpec.describe 'GetUsereWallPost', type: :request do
  let(:user) { create(:user, :with_auth_token, :with_wall) }

  let!(:wall_post) { create(:post, postable: user, wall: user.wall, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

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
    before { get '/api/profile/wall/posts/1', params: {}, headers: headers }

    it('returns wall') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/wall/posts/1', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'post was not found' do
    before { get '/api/profile/wall/posts/0', params: {}, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
