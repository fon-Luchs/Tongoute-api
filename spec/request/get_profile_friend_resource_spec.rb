require 'rails_helper'

RSpec.describe 'GetProfileFriendResource', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:friend_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski', id: 1) }

  let(:subscribe)        { create(:relationship, subscribed_id: user.id, subscriber_id: friend_user.id) }

  let(:friend_subscribe) { create(:relationship, subscribed_id: friend_user.id, subscriber_id: user.id) }

  let!(:user_friend) { friend_user }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:groups) do
    user_friend.groups.map do |group|
      { "id" => group.id, "name" => group.users, "users" => group.users.count }
    end
  end

  let(:relations) do
    user_friend.relations.map do |relation|
      { "id" => relation.user_id, "name" => relation.user_name, "relation" => relation.relation }
    end
  end

  let(:notes) do
    user_friend.notes.map do |note|
      { "id" => note.id, "title" => note.title, "body" => note.body }
    end
  end

  let(:info) do
    {
      "email" => user_friend.email,
      "number" => user_friend.number,
      "bday" => user_friend.date,
      "relations" => relations,
      "location" => "#{user.country}, #{user.locate}",
      "address" => user_friend.adres,
      "about self" => user_friend.about
    }
  end

  let(:resource_response) do
    {
      "id" => user_friend.id,
      "name" => "#{user_friend.first_name} #{user_friend.last_name}",
      "status" => 'Friend',
      "information" => info,
      "wall" => user_friend.wall,
      "groups" => user_friend.groups.count,
      "friends" => user_friend.friends,
      "video" => user_friend.videos,
      "photos" => user_friend.photos,
      "audios" => user_friend.audios,
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
end
