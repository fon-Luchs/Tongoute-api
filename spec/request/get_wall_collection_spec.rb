require 'rails_helper'

RSpec.describe 'GetWallCollection', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:posts) { create_list(:post, 3, user: user) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author) do
    {
      "id" => post.user_id,
      "name" => "#{post.user.first_name} #{post.user.last_name}"
    }
  end

  let(:post_response) do
    Post.all.map do |post|
      {
        "id" => post.id,
        "title" => post.title,
        "body" => post.body,
        "author" => author,
        "likes" => post.likes
      }
    end
  end

  describe 'Profile' do
    context do
      before { get '/api/profile/walls', params: {} , headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq post_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { get '/api/profile/walls', params: {}, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end
  end

  describe 'Profile' do
    context do
      before { get '/api/users/1/walls', params: {} , headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq post_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { get '/api/users/1/walls', params: {}, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end
  end
end
