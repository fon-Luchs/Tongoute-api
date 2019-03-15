require 'rails_helper'

RSpec.describe 'GetProfileFriendResource', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 2) }

  let(:friend_user) { create(:user, :with_wall, first_name: 'Jeffrey', last_name: 'Lebowski', id: 1) }

  let!(:relation)  { create(:relation, related_id: friend_user.id, relating_id: user.id, state: 1, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:owner) do
    {
      'id' => friend_user.id,
      'name' => "#{friend_user.first_name} #{friend_user.last_name}"
    }
  end

  let(:posts) do
    friend_user.wall.posts.map do |p|
      {
        'author' => owner,
        'body' => p.body,
        'id' => p.id,
        'likes' => 332
      }
    end
  end

  let(:wall) do
    {
      'id' => friend_user.wall.id,
      'owner' => owner,
      'posts' => posts
    }
  end

  let(:resource_response) do
    {
      'id' => relation.id,
      'status' => relation.state,
      'user' => {
        "audios" => 1,
        "friends" => 0,
        "groups" => friend_user.groups.count,
        "id" => friend_user.id,
        "information" => {
          "about_self" => nil,
          "address" => nil,
          "bday" => nil,
          "email" => friend_user.email,
          "location"=>", ",
          "number" => nil,
          "relation" => [
            {
              "id" => 23,
              "name" => "Jarry Smith",
              "relations" => "Best friend"
            },
            {
              "id" => 23,
              "name" => "Jarry Smith",
              "relations" => "Best friend"
            }
          ]
        },
        "name"=>"Jeffrey Lebowski",
        "photos"=>1,
        "subscribers"=>0,
        "videos"=>1,
        "wall"=>wall
      }
    }
  end

  context do
    before { get '/api/profile/friends/1', params: { id: 1 }, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/friends/1', params: { id: 1 }, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'friend was not found' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/friends/0', params: { id: 1 }, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status :unauthorized }
  end
end
