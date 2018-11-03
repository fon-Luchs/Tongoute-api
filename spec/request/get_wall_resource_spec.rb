require 'rails_helper'

RSpec.describe 'GetWallResource', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 1)}

  let!(:post) { create(:post, user: user, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author) do
    {
      "id" => post.user_id,
      "name" => "#{post.user.first_name} #{post.user.last_name}"
    }
  end

  let(:post_response) do
    {
      "id" => post.id,
      "title" => post.title,
      "body" => post.body,
      "author" => author,
      "likes" => post.likes
    }
  end

  describe 'Profile' do
    context do
      before { get '/api/profile/walls/1', params: {} , headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq post_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { get '/api/profile/walls/1', params: {}, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end
  end

  describe 'User' do
    context do
      before { get '/api/users/1/walls/1', params: {} , headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq post_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { get '/api/users/1/walls/1', params: {}, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end
  end
end
