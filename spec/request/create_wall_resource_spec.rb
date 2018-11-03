require 'rails_helper'

RSpec.describe 'CreateWallResource', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_params) { attributes_for(:post, user: user) }

  let(:params) { { post: resource_params } }

  let(:post_) { Post.last }

  let(:author) do
    {
      "id" => post_.user_id,
      "name" => "#{post_.user.first_name} #{post_.user.last_name}"
    }
  end

  let(:post_response) do
    {
      "id" => post_.id,
      "title" => post_.title,
      "body" => post_.body,
      "author" => author,
      "likes" => post_.likes
    }
  end

  before { create(:post, resource_params.merge(user: user)) }

  describe 'Profile controller' do

    context do
      before { post '/api/profile/walls', params: params.to_json, headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq post_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { post '/api/profile/walls', params: params.to_json, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end

    context 'invalid params' do
      before { post '/api/profile/walls', params: {}, headers: headers }

      it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
    end
  end

  describe 'User' do
    context do
      before { post '/api/users/2/walls', params: params.to_json, headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq post_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { post '/api/users/2/walls', params: params.to_json, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end

    context 'invalid params' do
      before { post '/api/users/2/walls', params: {}, headers: headers }

      it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
    end
  end
end
