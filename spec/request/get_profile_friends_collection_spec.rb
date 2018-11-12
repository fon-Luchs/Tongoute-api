require 'rails_helper'

RSpec.describe 'GetProfileFriendCollection', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:sub_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let(:subscriber)    { create(:subscriber, user: user, subscriber_id: sub_user.id ) }

  let!(:friend) { create(:friend, user: user, friend_id: subscriber.subscriber_id, id: 1) }

  let!(:user_friends) { user.friends }

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
    user_friends.all.map do |user|
    {
      "id" => user.id,
      "name" => "#{user.first_name} #{user.last_name}",
      "status" => 'Friend',
      "information" => info,
      "wall" => user.wall,
      "groups" => user.groups.count,
      "friends" => user.friends,
      "video" => user.videos,
      "photos" => user.photos,
      "audios" => user.audios,
    }
    end
  end

  context do
    before { get '/api/profile/friends/', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/friends/', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
