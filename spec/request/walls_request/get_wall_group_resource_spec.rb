require 'rails_helper'

RSpec.describe 'GetWallGroupResource', type: :request do
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
  end

  describe 'User' do
  end
end
